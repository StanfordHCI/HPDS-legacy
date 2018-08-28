//
//  ConsentSignatureResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

class UIImageBase64Transform: TransformType {
    
    typealias Object = UIImage
    typealias JSON = String
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let image = value,
            let data = UIImagePNGRepresentation(image)
        {
            return "data:image/png;base64,\(data.base64EncodedString())"
        }
        return nil
    }
    
}

extension ORKConsentSignature: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKConsentSignature()
    }

    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        requiresName <- map["requiresName"]
        requiresSignatureImage <- map["requiresSignatureImage"]
        identifier <- map["identifier"]
        title <- map["title"]
        givenName <- map["givenName"]
        familyName <- map["familyName"]
        signatureImage <- (map["signatureImage"], UIImageBase64Transform())
        signatureDate <- map["signatureDate"]
        signatureDateFormatString <- map["signatureDateFormatString"]
    }
    
}

open class ConsentSignatureResult: Result {
    
    @objc dynamic var signature: ORKConsentSignature?
    @objc dynamic var consented: Bool = false
    
    convenience init(consentSignatureResult: ORKConsentSignatureResult) {
        self.init(result: consentSignatureResult)
        
        signature = consentSignatureResult.signature
        consented = consentSignatureResult.consented
    }
    
    override open class func collectionName() -> String {
        return "ConsentSignatureResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        signature <- map["signature"]
        consented <- map["consented"]
    }
    
}
