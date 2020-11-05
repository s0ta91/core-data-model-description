//
//  CoreDataAttributeDescription.swift
//  CoreDataModelDescription
//
//  Created by Dmytro Anokhin on 12/08/2019.
//  Copyright © 2019 Dmytro Anokhin. All rights reserved.
//

import CoreData


/// Describes and creates`NSAttributeDescription`
public struct CoreDataAttributeDescription {

    public static func attribute(name: String, type: NSAttributeType, customClassName: String? = nil, isOptional: Bool = false, defaultValue: Any? = nil, isIndexedBySpotlight: Bool = false) -> CoreDataAttributeDescription {
        return CoreDataAttributeDescription(name: name, attributeType: type, customClassName: customClassName, isOptional: isOptional, defaultValue: defaultValue, isIndexedBySpotlight: isIndexedBySpotlight)
    }

    public var name: String

    public var attributeType: NSAttributeType
    
    public var customClassName: String?

    public var isOptional: Bool
    
    public var defaultValue: Any?
    
    public var isIndexedBySpotlight: Bool

    public func makeAttribute() -> NSAttributeDescription {
        let attribute = NSAttributeDescription()
        attribute.name = name
        attribute.attributeType = attributeType
        if attributeType == .transformableAttributeType {
            attribute.attributeValueClassName = customClassName
            var transformerName = "NSSecureUnarchiveFromData"
            if let customClassName = customClassName {
                transformerName = "\(customClassName)Transformer"
            }
            attribute.valueTransformerName = transformerName
        }
        attribute.isOptional = isOptional
        attribute.defaultValue = defaultValue
        attribute.isIndexedBySpotlight = isIndexedBySpotlight

        return attribute
    }
}
