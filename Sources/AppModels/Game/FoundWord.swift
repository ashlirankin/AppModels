//
//  FoundWord.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import SwiftUI

public struct FoundWord: Codable, Hashable, Sendable {
    
    enum CodingKeys: CodingKey {
        case word
        case positions
        case colorIndex
    }
    
    public let word: String
    public let positions: [SharedGridPosition]
    public let colorIndex: Int
    
    public var color: Color {
        FoundWord.colors[colorIndex % FoundWord.colors.count]
    }
    
    public static let colors: [Color] = [
        .green,
        .blue,
        .purple,
        .orange,
        .pink,
        .teal,
        .yellow,
        .mint
    ]
    
    public init(word: String, positions: [SharedGridPosition], colorIndex: Int) {
        self.word = word
        self.positions = positions
        self.colorIndex = colorIndex
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let workContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .word)
        self.word = try workContainer.decode(String.self, forKey: .stringValue)
        
        let colorIndexContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .colorIndex)
        self.colorIndex = try colorIndexContainer.decode(Int.self, forKey: .integerValue)
        
        self.positions = try container.decode([SharedGridPosition].self, forKey: .positions)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var wordContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .word)
        try wordContainer.encode(word, forKey: .stringValue)
        
        var colorIndexContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .colorIndex)
        try colorIndexContainer.encode(colorIndex, forKey: .integerValue)
        
        try container.encode(self.positions, forKey: .positions)
    }
}
