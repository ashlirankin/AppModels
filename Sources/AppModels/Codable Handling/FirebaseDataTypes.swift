//
//  FirebaseDataTypes.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//


import Foundation

public enum FirebaseDataTypes: String, CodingKey {
    case stringValue = "stringValue"
    case integerValue = "integerValue"
    case doubleValue = "doubleValue"
    case nullValue = "nullValue"
    case timestampValue = "timestampValue"
    case referenceValue = "referenceValue"
    case booleanValue = "booleanValue"
    case arrayValue = "arrayValue"
    case mapValue = "mapValue"
    case geoPointValue = "geopointValue"
}


public enum SupplementaryCodingKeys: String, CodingKey {
    case values
}
