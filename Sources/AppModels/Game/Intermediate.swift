//
//  Intermediate.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/17/25.
//

import Foundation

/// A struct representing an intermediate state during word search puzzle generation.
/// This struct holds temporary configuration data used while creating a new puzzle.
public struct Intermediate: Identifiable {
    /// The list of words to be placed in the puzzle grid.
    public var words: [String]
    
    /// The time limit for solving the puzzle, in seconds.
    public var timeLimit: Int
    
    /// The size of the square grid (width and height).
    public var gridSize: Int
    
    /// A unique identifier for this intermediate state.
    public var id = UUID()
    
    /// Creates a new intermediate state for puzzle generation.
    /// - Parameters:
    ///   - words: The list of words to be placed in the puzzle
    ///   - timeLimit: The time limit for solving the puzzle, in seconds
    ///   - gridSize: The size of the square grid
    ///   - id: A unique identifier for this state (defaults to a new UUID)
    public init(words: [String], timeLimit: Int, gridSize: Int, id: UUID = UUID()) {
        self.words = words
        self.timeLimit = timeLimit
        self.gridSize = gridSize
        self.id = id
    }
}
