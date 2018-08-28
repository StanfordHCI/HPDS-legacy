//
//  TowerOfHanoiResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

extension ORKTowerOfHanoiMove: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKTowerOfHanoiMove()
    }

    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        timestamp <- map["timestamp"]
        donorTowerIndex <- map["donorTowerIndex"]
        recipientTowerIndex <- map["recipientTowerIndex"]
    }
    
}

open class TowerOfHanoiResult: Result {
    
    @objc dynamic var puzzleWasSolved: Bool = false
    @objc dynamic var moves: [ORKTowerOfHanoiMove]?
    
    convenience init(towerOfHanoiResult: ORKTowerOfHanoiResult) {
        self.init(result: towerOfHanoiResult)
        
        puzzleWasSolved = towerOfHanoiResult.puzzleWasSolved
        moves = towerOfHanoiResult.moves
    }
    
    override open class func collectionName() -> String {
        return "TowerOfHanoiResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        puzzleWasSolved <- map["puzzleWasSolved"]
        moves <- map["moves"]
    }
    
}
