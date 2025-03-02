//
//  SharedGridPosition.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

public struct SharedGridPosition: Equatable, Hashable, Codable, Sendable {
    
    enum CodingKeys: CodingKey {
        case row
        case col
    }
    
    public let row: Int
    public let col: Int
    
    public init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.row = try container.decode(FirebaseValue<Int>.self, forKey: .row).value
        self.col = try container.decode(FirebaseValue<Int>.self, forKey: .col).value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(FirebaseValue(value: row), forKey: .row)
        try container.encode(FirebaseValue(value: col), forKey: .col)
    }
    
    public static func from(tuple: (Int, Int)) -> SharedGridPosition {
        SharedGridPosition(row: tuple.0, col: tuple.1)
    }
    
    public var asTuple: (Int, Int) {
        (row, col)
    }
}
