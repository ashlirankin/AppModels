//
//  FoundWord.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//

import Foundation

/// Represents a word that has been found in the word search puzzle.
/// This struct contains information about the word itself, its position in the grid,
/// and the color used to highlight it.
public struct FoundWord: Codable, Hashable, Sendable {
    
    /// Keys used for encoding and decoding found words to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The actual word that was found
        case word
        /// The positions in the grid where the word was found
        case positions
        /// The index of the color used to highlight this word
        case colorIndex
    }
    
    /// The actual word that was discovered in the puzzle.
    public let word: String
    
    /// An array of grid positions that make up this word.
    /// These positions represent the sequence of letters in the grid that form the word.
    public let positions: [SharedGridPosition]
    
    /// The index of the color used to highlight this word in the UI.
    /// This helps visually distinguish different found words in the puzzle.
    public let colorIndex: Int
    
    /// Creates a new found word instance.
    /// - Parameters:
    ///   - word: The actual word that was found
    ///   - positions: The positions in the grid where the word was found
    ///   - colorIndex: The index of the color used to highlight this word
    public init(word: String, positions: [SharedGridPosition], colorIndex: Int) {
        self.word = word
        self.positions = positions
        self.colorIndex = colorIndex
    }
    
    /// Creates a new instance by decoding from Firebase format.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if decoding fails.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       
        self.word = try container.decode(FirebaseValue<String>.self, forKey: .word).value
        self.colorIndex = try container.decode(FirebaseValue<Int>.self, forKey: .colorIndex).value
        
        self.positions = try container.decode([SharedGridPosition].self, forKey: .positions)
    }
    
    /// Encodes this found word into Firebase format.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: An error if encoding fails.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(FirebaseValue(value: word), forKey: .word)
        try container.encode(FirebaseValue(value: colorIndex), forKey: .colorIndex)
        try container.encode(self.positions, forKey: .positions)
    }
}
