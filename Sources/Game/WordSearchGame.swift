import Foundation

public protocol WordSearchGame {
    var grid: [[Character]] { get }
    var words: [String] { get }
    var foundWords: Set<String> { get }
    var foundWordPositions: [FoundWord] { get }
    
    func positionsForWord(_ word: String) -> [SharedGridPosition]?
    func checkWord(_ word: String, positions: [(Int, Int)]) -> Bool
}
