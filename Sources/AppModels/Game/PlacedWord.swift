import Foundation
import SwiftUI

public struct PlacedWord: Codable, Sendable {
    public let word: String
    public let startPosition: SharedGridPosition
    public let direction: Direction
    public let positions: [SharedGridPosition]
}

public struct Direction: Codable, Sendable {
    public let x: Int
    public let y: Int
}
