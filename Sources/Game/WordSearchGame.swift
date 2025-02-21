import Foundation

public protocol WordSearchGame {
    public var grid: [[Character]] { get }
    public var words: [String] { get }
    public var foundWords: Set<String> { get }
    public var foundWordPositions: [FoundWord] { get }
    
    public func positionsForWord(_ word: String) -> [SharedGridPosition]?
    public func checkWord(_ word: String, positions: [(Int, Int)]) -> Bool
}
