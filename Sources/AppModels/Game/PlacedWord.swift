import Foundation
import SwiftUI

public struct PlacedWord: Codable, Sendable {
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
}

public struct Direction: Codable, Sendable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
