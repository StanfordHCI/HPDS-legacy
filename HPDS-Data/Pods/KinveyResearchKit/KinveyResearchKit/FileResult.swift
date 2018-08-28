//
//  FileResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import PromiseKit
import ObjectMapper

class URLBase64Transform: TransformType {
    
    typealias Object = URL
    typealias JSON = String
    
    let contentType: String?
    
    init(contentType: String?) {
        self.contentType = contentType
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let url = value,
            let data = try? Data(contentsOf: url)
        {
            let contentType = self.contentType ?? ""
            return "data:\(contentType);base64,\(data.base64EncodedString())"
        }
        return nil
    }
    
}

class URLContentStringTransform: TransformType {
    
    typealias Object = URL
    typealias JSON = String
    
    let contentType: String?
    
    init(contentType: String?) {
        self.contentType = contentType
    }
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let url = value,
            let data = try? Data(contentsOf: url),
            let string = String(data: data, encoding: .utf8)
        {
            let contentType = self.contentType ?? ""
            return "data:\(contentType);charset=utf-8,\(string)"
        }
        return nil
    }
    
}

open class FileResult: Result {
    
    @objc dynamic var contentType: String?
    @objc dynamic var fileURL: URL?
    
    private var fileReference: FileReference?
    
    convenience init(fileResult: ORKFileResult) {
        self.init(result: fileResult)
        
        contentType = fileResult.contentType
        fileURL = fileResult.fileURL
    }
    
    override open class func collectionName() -> String {
        return "FileResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        fileReference <- map["reference"]
    }
    
    override func saveReferences() -> Promise<[ObjectReference]> {
        return Promise<[ObjectReference]> { fulfill, reject in
            if let fileURL = fileURL {
                let file = File()
                file.mimeType = contentType
                file.fileName = fileURL.lastPathComponent
                FileStore().upload(file, path: fileURL.path) { file, error in
                    if let file = file, let fileId = file.fileId {
                        let fileReference = FileReference(id: fileId)
                        self.fileReference = fileReference
                        fulfill([fileReference])
                    } else if let error = error {
                        reject(error)
                    } else {
                        reject(Kinvey.Error.invalidResponse(httpResponse: nil, data: nil))
                    }
                }
            } else {
                fulfill([])
            }
        }
    }
    
}
