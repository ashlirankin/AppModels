//
//  FirebaseDataTypes.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//


import Foundation

public enum FirebaseDataTypes: String, CodingKey {
    case stringValue
    case integerValue
    case nullValue
    case timestampValue
    case referenceValue
    case booleanValue
    case arrayValue
    case mapValue
    case geoPointValue
}


public enum SupplementaryCodingKeys: String, CodingKey {
    case values
}
