import Foundation

/// Represents a word that has been placed in the word search grid.
/// This struct contains information about the word's position and orientation in the puzzle.
public struct PlacedWord: Codable, Sendable {
    
    /// Keys used for encoding and decoding placed words to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The actual word that was placed
        case word
        /// The starting position of the word in the grid
        case startPosition
        /// The direction the word extends in
        case direction
        /// All positions occupied by the word
        case positions
    }
    
    /// The word that was placed in the grid.
    public let word: String
    
    /// The starting position of the word in the grid.
    public let startPosition: SharedGridPosition
    
    /// The direction in which the word extends from its starting position.
    public let direction: Direction
    
    /// All grid positions occupied by this word.
    public let positions: [SharedGridPosition]
    
    /// Creates a new placed word instance.
    /// - Parameters:
    ///   - word: The word that was placed
    ///   - startPosition: The starting position in the grid
    ///   - direction: The direction the word extends in
    ///   - positions: All positions occupied by the word
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

/// Represents a direction in the grid using x and y coordinates.
public struct Direction: Codable, Sendable {
    
    /// Keys used for encoding and decoding directions to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The x-coordinate of the direction vector
        case x
        /// The y-coordinate of the direction vector
        case y
    }
    
    /// The x-component of the direction vector.
    public let x: Int
    
    /// The y-component of the direction vector.
    public let y: Int
    
    /// Creates a new direction instance.
    /// - Parameters:
    ///   - x: The x-component of the direction
    ///   - y: The y-component of the direction
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.x = try container.decode(FirebaseValue<Int>.self, forKey: .x).value
        self.y = try container.decode(FirebaseValue<Int>.self, forKey: .y).value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(FirebaseValue(value: x), forKey: .x)
        try container.encode(FirebaseValue(value: y), forKey: .y)
    }
}
