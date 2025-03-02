//
//  Intermediate.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/17/25.
//

import Foundation

public struct Intermediate: Identifiable {
    public var words: [String]
    public var timeLimit: Int
    public var gridSize: Int
    public var id = UUID()
    
    public init(words: [String], timeLimit: Int, gridSize: Int, id: UUID = UUID()) {
        self.words = words
        self.timeLimit = timeLimit
        self.gridSize = gridSize
        self.id = id
    }
}
