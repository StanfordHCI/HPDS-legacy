//
//  CollectionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import PromiseKit
import ObjectMapper

class ObjectReference: Mappable {
    
    var collection: String
    var id: String
    
    init(collection: String, id: String = UUID().uuidString) {
        self.collection = collection
        self.id = id
    }
    
    required init?(map: Map) {
        guard
            let collection = map["collection"].currentValue as? String,
            let id = map["_id"].currentValue as? String
        else {
            return nil
        }
        
        self.collection = collection
        self.id = id
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    func mapping(map: Map) {
        collection <- map["collection"]
        id <- map["_id"]
    }
    
}

class FileReference: ObjectReference {
    
    init(id: String = UUID().uuidString) {
        super.init(collection: "_blob", id: id)
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
}

let TaskResultCollectionName = TaskResult.collectionName()

class ResultTransformer<T: Result>: TransformType {
    
    typealias Object = T
    typealias JSON = ObjectReference
    
    func transformToJSON(_ value: T?) -> ObjectReference? {
        if let value = value, let identifier = value.identifier {
            return ObjectReference(collection: T.collectionName(), id: identifier)
        }
        return nil
    }
    
    func transformFromJSON(_ value: Any?) -> T? {
        if let value = value as? [String : String],
            let kinveyRef = ObjectReference(JSON: value)
        {
            switch kinveyRef.collection {
            case TaskResultCollectionName:
                break
            default:
                break
            }
        }
        return nil
    }
    
}

class ResultArrayTransformer: TransformType {
    
    typealias Object = [Result]
    typealias JSON = [[String : Any]]
    
    func transformFromJSON(_ value: Any?) -> Array<Result>? {
        if let values = value as? [[String : Any]] {
            var results = [Result]()
            for result in values {
                if let result = ResultTransformer<Result>().transformFromJSON(result) {
                    results.append(result)
                }
            }
            return results
        }
        return nil
    }
    
    func transformToJSON(_ value: Array<Result>?) -> [[String : Any]]? {
        if let value = value {
            var results = [ObjectReference]()
            for result in value {
                var kinveyRef: ObjectReference? = nil
                if let taskResult = result as? TaskResult {
                    kinveyRef = ResultTransformer<TaskResult>().transformToJSON(taskResult)
                } else if let taskResult = result as? StepResult {
                    kinveyRef = ResultTransformer<StepResult>().transformToJSON(taskResult)
                } else if let taskResult = result as? NumericQuestionResult {
                    kinveyRef = ResultTransformer<NumericQuestionResult>().transformToJSON(taskResult)
                } else if let taskResult = result as? TimeIntervalQuestionResult {
                    kinveyRef = ResultTransformer<TimeIntervalQuestionResult>().transformToJSON(taskResult)
                } else {
                    kinveyRef = nil
                }
                if let kinveyRef = kinveyRef {
                    results.append(kinveyRef)
                }
            }
            return results.toJSON()
        }
        return nil
    }
    
}

open class CollectionResult: Result {
    
    @objc dynamic var results: [Result]?
    
    var firstResult: Result? {
        get { return results?.first }
    }
    
    internal convenience init(collectionResult: ORKCollectionResult) {
        self.init(result: collectionResult)
        
        results = build(collectionResult.results)
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        if writeNestedObjectsUsingReferences {
            results <- (map["results"], ResultArrayTransformer())
        } else {
            results <- map["results"]
        }
    }
    
    override func saveReferences() -> Promise<[ObjectReference]> {
        return Promise<[ObjectReference]> { fulfill, reject in
            var promises = [Promise<[ObjectReference]>]()
            if let results = results {
                for result in results {
                    promises.append(result.saveReferences())
                }
            }
            let _ = when(fulfilled: promises).then { references in
                fulfill(references.flatMap { $0 })
            }
        }
    }
    
}
