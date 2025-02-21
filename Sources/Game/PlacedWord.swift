import Foundation
import SwiftUI

public struct PlacedWord {
    public let word: String
    public let startPosition: SharedGridPosition
    public let direction: (Int, Int)
    public let positions: [SharedGridPosition]
}
