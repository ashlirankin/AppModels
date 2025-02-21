//
//  SharedGridPosition.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//

public struct SharedGridPosition: Equatable, Hashable, Codable, Sendable {
    public let row: Int
    public let col: Int
    
    public static func from(tuple: (Int, Int)) -> SharedGridPosition {
        SharedGridPosition(row: tuple.0, col: tuple.1)
    }
    
    public var asTuple: (Int, Int) {
        (row, col)
    }
}
