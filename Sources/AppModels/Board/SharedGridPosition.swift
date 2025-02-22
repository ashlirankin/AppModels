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
        
        let rowContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .row)
        self.row = try rowContainer.decode(Int.self, forKey: .integerValue)
        
        let colContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .col)
        self.col = try rowContainer.decode(Int.self, forKey: .integerValue)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var rowContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .row)
        try rowContainer.encode(row, forKey: .integerValue)
       
        let colContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .col)
        try rowContainer.encode(col, forKey: .integerValue)
    }
    
    public static func from(tuple: (Int, Int)) -> SharedGridPosition {
        SharedGridPosition(row: tuple.0, col: tuple.1)
    }
    
    public var asTuple: (Int, Int) {
        (row, col)
    }
}
