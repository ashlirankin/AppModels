import Foundation
import SwiftUI

public struct PlacedWord {
    let word: String
    let startPosition: SharedGridPosition
    let direction: (Int, Int)
    let positions: [SharedGridPosition]
}
