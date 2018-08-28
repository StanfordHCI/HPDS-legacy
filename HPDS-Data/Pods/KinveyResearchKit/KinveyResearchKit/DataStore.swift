//
//  DataStore.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-23.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import PromiseKit

class PromiseRequest<T>: NSObject, Request {
    
    var executing: Bool {
        get {
            return promise.isResolved
        }
    }
    
    /// Indicates if a request was cancelled or not.
    var cancelled = false
    
    /// Cancels a request in progress.
    func cancel() {
        cancelled = true
    }
    
    /// Report upload progress of the request
    var progress: ((Kinvey.ProgressStatus) -> Swift.Void)?
    
    let promise: Promise<T>
    
    init(promise: Promise<T>) {
        self.promise = promise
    }
    
}

public extension DataStore {
    
    @discardableResult
    internal func save<CollectionResultType: ORKCollectionResult>(results: CollectionResultType, writePolicy: WritePolicy? = nil) -> Promise<[Result]> {
        var promises = [Promise<Result>]()
        if writeNestedObjectsUsingReferences, let results = results.results {
            for result in results {
                var promise: Promise<Result>? = nil
                if let stepResult = result as? ORKStepResult {
                    promise = Promise<Result> { fulfill, reject in
                        collection(newType: StepResult.self).save(stepResult) { stepResult, error in
                            if let stepResult = stepResult {
                                fulfill(stepResult)
                            } else if let error = error {
                                reject(error)
                            } else {
                                reject(Kinvey.Error.invalidResponse(httpResponse: nil, data: nil))
                            }
                        }
                    }
                } else if let taskResult = result as? ORKTaskResult {
                    promise = Promise<Result> { fulfill, reject in
                        collection(newType: TaskResult.self).save(taskResult) { taskResult, error in
                            if let taskResult = taskResult {
                                fulfill(taskResult)
                            } else if let error = error {
                                reject(error)
                            } else {
                                reject(Kinvey.Error.invalidResponse(httpResponse: nil, data: nil))
                            }
                        }
                    }
                } else if let numbericQuestionResult = result as? ORKNumericQuestionResult {
                    promise = Promise<Result> { fulfill, reject in
                        collection(newType: NumericQuestionResult.self).save(numbericQuestionResult) { numbericQuestionResult, error in
                            if let numbericQuestionResult = numbericQuestionResult {
                                fulfill(numbericQuestionResult)
                            } else if let error = error {
                                reject(error)
                            } else {
                                reject(Kinvey.Error.invalidResponse(httpResponse: nil, data: nil))
                            }
                        }
                    }
                } else if let timeIntervalQuestionResult = result as? ORKTimeIntervalQuestionResult {
                    promise = Promise<Result> { fulfill, reject in
                        collection(newType: TimeIntervalQuestionResult.self).save(timeIntervalQuestionResult) { timeIntervalQuestionResult, error in
                            if let timeIntervalQuestionResult = timeIntervalQuestionResult {
                                fulfill(timeIntervalQuestionResult)
                            } else if let error = error {
                                reject(error)
                            } else {
                                reject(Kinvey.Error.invalidResponse(httpResponse: nil, data: nil))
                            }
                        }
                    }
                }
                if let promise = promise {
                    promises.append(promise)
                }
            }
        }
        return when(fulfilled: promises)
    }
    
}

public extension DataStore where T: TaskResult {
    
    @discardableResult
    public func save(_ persistable: ORKTaskResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        return save(persistable, writePolicy: writePolicy) { (result: Kinvey.Result<T, Swift.Error>) in
            switch result {
            case .success(let stepResult):
                completionHandler?(stepResult, nil)
            case .failure(let error):
                completionHandler?(nil, error)
            }
        }
    }
    
    @discardableResult
    public func save(_ persistable: ORKTaskResult, writePolicy: WritePolicy? = nil, completionHandler: ((Kinvey.Result<T, Swift.Error>) -> Void)?) -> Request {
        let promise = save(results: persistable, writePolicy: writePolicy).then { results -> Promise<TaskResult?> in
            let taskResult = TaskResult(taskResult: persistable)
            return taskResult.saveReferences().then { _ in
                return Promise<TaskResult?> { fulfill, reject in
                    self.save(
                        taskResult as! T,
                        options: Options(
                            writePolicy: writePolicy
                        )
                    ) { (result: Kinvey.Result<T, Swift.Error>) in
                        switch result {
                        case .success(let stepResult):
                            fulfill(stepResult)
                        case .failure(let error):
                            reject(error)
                        }
                        completionHandler?(result)
                    }
                }
            }
        }
        return PromiseRequest(promise: promise)
    }
    
}

public extension DataStore where T: StepResult {
    
    @discardableResult
    public func save(_ persistable: ORKStepResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        return save(persistable, writePolicy: writePolicy) { (result: Kinvey.Result<T, Swift.Error>) in
            switch result {
            case .success(let stepResult):
                completionHandler?(stepResult, nil)
            case .failure(let error):
                completionHandler?(nil, error)
            }
        }
    }
    
    @discardableResult
    public func save(_ persistable: ORKStepResult, writePolicy: WritePolicy? = nil, completionHandler: ((Kinvey.Result<T, Swift.Error>) -> Void)?) -> Request {
        let promise = save(results: persistable, writePolicy: writePolicy).then { results -> Promise<StepResult?> in
            let stepResult = StepResult(stepResult: persistable)
            return Promise<StepResult?> { fulfill, reject in
                self.save(
                    stepResult as! T,
                    options: Options(
                        writePolicy: writePolicy
                    )
                ) { (result: Kinvey.Result<T, Swift.Error>) in
                    switch result {
                    case .success(let stepResult):
                        fulfill(stepResult)
                    case .failure(let error):
                        reject(error)
                    }
                    completionHandler?(result)
                }
            }
        }
        return PromiseRequest(promise: promise)
    }
    
}

public extension DataStore where T: NumericQuestionResult {
    
    @discardableResult
    public func save(_ persistable: ORKNumericQuestionResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        return save(persistable, writePolicy: writePolicy) { (result: Kinvey.Result<T, Swift.Error>) in
            switch result {
            case .success(let stepResult):
                completionHandler?(stepResult, nil)
            case .failure(let error):
                completionHandler?(nil, error)
            }
        }
    }
    
    @discardableResult
    public func save(_ persistable: ORKNumericQuestionResult, writePolicy: WritePolicy? = nil, completionHandler: ((Kinvey.Result<T, Swift.Error>) -> Void)?) -> Request {
        let numericQuestionResult = NumericQuestionResult(numericQuestionResult: persistable)
        return save(
            numericQuestionResult as! T,
            options: Options(
                writePolicy: writePolicy
            ),
            completionHandler: completionHandler
        )
    }
    
}

public extension DataStore where T: TimeIntervalQuestionResult {
    
    @discardableResult
    public func save(_ persistable: ORKTimeIntervalQuestionResult, writePolicy: WritePolicy? = nil, completionHandler: ObjectCompletionHandler?) -> Request {
        return save(persistable, writePolicy: writePolicy) { (result: Kinvey.Result<T, Swift.Error>) in
            switch result {
            case .success(let stepResult):
                completionHandler?(stepResult, nil)
            case .failure(let error):
                completionHandler?(nil, error)
            }
        }
    }
    
    @discardableResult
    public func save(_ persistable: ORKTimeIntervalQuestionResult, writePolicy: WritePolicy? = nil, completionHandler: ((Kinvey.Result<T, Swift.Error>) -> Void)?) -> Request {
        let timeIntervalQuestionResult = TimeIntervalQuestionResult(timeIntervalQuestionResult: persistable)
        return save(
            timeIntervalQuestionResult as! T,
            options: Options(
                writePolicy: writePolicy
            ),
            completionHandler: completionHandler
        )
    }
    
}
