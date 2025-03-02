//
//  StringValue.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/22/25.
//

import Foundation

/// A generic wrapper struct that handles encoding and decoding of Firebase-compatible values.
/// This struct provides a standardized way to encode values in Firebase's expected JSON format.
///
/// Example usage:
/// ```swift
/// let stringValue = FirebaseValue(value: "Hello")
/// ```
///
/// - Note: The generic type `T` must conform to `FirebaseCodable` to ensure proper Firebase compatibility.
public struct FirebaseValue<T: FirebaseCodable>: Sendable, Codable, Equatable {
    
    /// Keys used for coding and decoding the Firebase value.
    enum CodingKeys: CodingKey {
        case value
    }

    /// The wrapped value of type `T` that will be encoded/decoded according to Firebase's format.
    public let value: T
    
    /// Creates a new `FirebaseValue` instance with the specified value.
    /// - Parameter value: The value to be wrapped for Firebase compatibility.
    init(value: T) {
        self.value = value
    }
    
    /// Encodes the wrapped value according to Firebase's expected format.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: An error if encoding fails.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: FirebaseDataTypes.self)
        try container.encode(value, forKey: T.codingKey)
    }
    
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if decoding fails.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: FirebaseDataTypes.self)
        self.value = try container.decode(T.type, forKey: T.codingKey)
    }
}

/// A protocol that defines requirements for types that can be encoded and decoded
/// in Firebase's data format.
///
/// Types conforming to this protocol must specify:
/// - The Firebase data type they correspond to
/// - Their concrete type for proper type inference during decoding
public protocol FirebaseCodable: Sendable, Codable, Equatable {
    /// The Firebase data type that this value should be encoded/decoded as.
    static var codingKey: FirebaseDataTypes { get }
    
    /// The concrete type of the value, used for proper type inference during decoding.
    static var type: Self.Type { get }
}
