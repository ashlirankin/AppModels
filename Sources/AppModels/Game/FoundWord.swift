//
//  FoundWord.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import Foundation

public struct FoundWord: Codable, Hashable, Sendable {
    
    enum CodingKeys: CodingKey {
        case word
        case positions
        case colorIndex
    }
    
    public let word: String
    public let positions: [SharedGridPosition]
    public let colorIndex: Int
    
    public init(word: String, positions: [SharedGridPosition], colorIndex: Int) {
        self.word = word
        self.positions = positions
        self.colorIndex = colorIndex
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       
        self.word = try container.decode(FirebaseValue<String>.self, forKey: .word).value
        self.colorIndex = try container.decode(FirebaseValue<Int>.self, forKey: .colorIndex).value
        
        self.positions = try container.decode([SharedGridPosition].self, forKey: .positions)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(FirebaseValue(value: word), forKey: .word)
        try container.encode(FirebaseValue(value: colorIndex), forKey: .colorIndex)
        try container.encode(self.positions, forKey: .positions)
    }
}
