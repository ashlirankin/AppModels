import Foundation

/// A collection of themed word lists for different difficulty levels.
/// Each theme pack contains sets of words appropriate for easy, medium, and hard difficulty levels.
public struct ThemePack: Sendable, Identifiable, Codable {
    
    /// Keys used for encoding and decoding theme packs to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The unique identifier of the theme pack
        case id
        /// The name of the theme
        case theme
        /// The list of words for easy difficulty
        case easy
        /// The list of words for medium difficulty
        case medium
        /// The list of words for hard difficulty
        case hard
        
        case category
    }
    
    /// A unique identifier for this theme pack.
    public let id: UUID
    
    /// The name or description of this theme.
    public let theme: String
    
    public let category: String
    
    /// The list of words for easy difficulty puzzles.
    public let easy: [String]
    
    /// The list of words for medium difficulty puzzles.
    public let medium: [String]
    
    /// The list of words for hard difficulty puzzles.
    public let hard: [String]
    
    /// Creates a new theme pack with the specified words for each difficulty level.
    /// - Parameters:
    ///   - theme: The name of the theme
    ///   - easy: The list of words for easy difficulty
    ///   - medium: The list of words for medium difficulty
    ///   - hard: The list of words for hard difficulty
    public init(theme: String, category: String, easy: [String], medium: [String], hard: [String]) {
        self.id = UUID()
        self.category = category
        self.theme = theme
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.id = try container.decode(FirebaseValue<UUID>.self, forKey: .id).value
        self.theme = try container.decode(FirebaseValue<String>.self, forKey: .theme).value
        self.category = try container.decode(FirebaseValue<String>.self, forKey: .category).value
        let easyContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .easy)
        let arrayContainer = try easyContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.easy = try arrayContainer.decode([FirebaseValue<String>].self, forKey: .values).map(\.value)
       
        let mediumContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        let mediumArrayContainer = try mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.medium = try mediumArrayContainer.decode([FirebaseValue<String>].self, forKey: .values).map(\.value)
       
        let hardContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        let hardArrayContainer = try hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.hard = try hardArrayContainer.decode([FirebaseValue<String>].self, forKey: .values).map(\.value)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(FirebaseValue(value: id), forKey: .id)
        try container.encode(FirebaseValue(value: theme), forKey: .theme)
        try container.encode(FirebaseValue(value: category), forKey: .category)
        
        var easyContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .easy)
        var arrayEasyContainer = easyContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        
        let easyNewValue = easy.map {FirebaseValue(value: $0) }
        try arrayEasyContainer.encode(easyNewValue, forKey: .values)
        
        var mediumContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        var mediumArrayEasyContainer = mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        
        let newValues = medium.map {FirebaseValue(value: $0) }
        try mediumArrayEasyContainer.encode(newValues, forKey: .values)
        
        var hardContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        var hardArrayEasyContainer = hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        
        let hardNewValues = hard.map { FirebaseValue(value: $0) }
        try hardArrayEasyContainer.encode(hardNewValues, forKey: .values)
    }
}
