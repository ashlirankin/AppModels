//
//  FirebaseDataTypes.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

import Foundation

/// Represents the different data types supported by Firebase's Firestore database in its JSON structure.
/// These cases correspond to the field types in Firestore's REST API response format.
public enum FirebaseDataTypes: String, CodingKey {
    /// Represents a string value in Firestore
    case stringValue = "stringValue"
    
    /// Represents an integer value in Firestore
    case integerValue = "integerValue"
    
    /// Represents a double/float value in Firestore
    case doubleValue = "doubleValue"
    
    /// Represents a null value in Firestore
    case nullValue = "nullValue"
    
    /// Represents a timestamp value in Firestore
    case timestampValue = "timestampValue"
    
    /// Represents a reference value (document reference) in Firestore
    case referenceValue = "referenceValue"
    
    /// Represents a boolean value in Firestore
    case booleanValue = "booleanValue"
    
    /// Represents an array value in Firestore
    case arrayValue = "arrayValue"
    
    /// Represents a map (dictionary/object) value in Firestore
    case mapValue = "mapValue"
    
    /// Represents a geographical point value in Firestore
    case geoPointValue = "geopointValue"
}

/// Supplementary coding keys used for handling nested structures in Firebase's JSON responses.
public enum SupplementaryCodingKeys: String, CodingKey {
    /// Used to decode array values within Firebase's nested JSON structure
    case values
}
