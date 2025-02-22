import Foundation
import SwiftUI

public struct PlacedWord: Codable, Sendable {
    
    enum CodingKeys: CodingKey {
        case word
        case startPosition
        case direction
        case positions
    }
    
    public let word: String
    public let startPosition: SharedGridPosition
    public let direction: Direction
    public let positions: [SharedGridPosition]
    
    public init(word: String, startPosition: SharedGridPosition, direction: Direction, positions: [SharedGridPosition]) {
        self.word = word
        self.startPosition = startPosition
        self.direction = direction
        self.positions = positions
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       
        let wordContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .word)
        self.word = try wordContainer.decode(String.self, forKey: .stringValue)
        
        self.startPosition = try container.decode(SharedGridPosition.self, forKey: .startPosition)
        self.direction = try container.decode(Direction.self, forKey: .direction)
        self.positions = try container.decode([SharedGridPosition].self, forKey: .positions)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.word, forKey: .word)
        try container.encode(self.startPosition, forKey: .startPosition)
        try container.encode(self.direction, forKey: .direction)
        try container.encode(self.positions, forKey: .positions)
    }
}

public struct Direction: Codable, Sendable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
