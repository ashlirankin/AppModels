import Foundation

/// A protocol defining the core functionality of a word search puzzle game.
/// This protocol provides the essential methods and properties needed to implement
/// a word search puzzle game.
public protocol WordSearchGame {
    /// The 2D grid of characters representing the puzzle board.
    var grid: [[Character]] { get }
    
    /// The list of words that players need to find in the puzzle.
    var words: [String] { get }
    
    /// The set of words that have been successfully found by players.
    var foundWords: Set<String> { get }
    
    /// The collection of found words and their positions in the grid.
    var foundWordPositions: [FoundWord] { get }
    
    /// Returns the grid positions for a specific word if it exists in the puzzle.
    /// - Parameter word: The word to find positions for
    /// - Returns: An array of grid positions if the word is found, nil otherwise
    func positionsForWord(_ word: String) -> [SharedGridPosition]?
    
    /// Checks if a word exists at the specified positions in the grid.
    /// - Parameters:
    ///   - word: The word to check for
    ///   - positions: The grid positions to check
    /// - Returns: True if the word exists at the specified positions, false otherwise
    func checkWord(_ word: String, positions: [(Int, Int)]) -> Bool
}
