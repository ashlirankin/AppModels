import Foundation

public struct ThemePack: Sendable, Identifiable, Codable {
    
    enum CodingKeys: CodingKey {
        case id
        case theme
        case easy
        case medium
        case hard
    }
    
    public let id: UUID
    public let theme: String
    public let easy: [String]
    public let medium: [String]
    public let hard: [String]
    
    public init(theme: String, easy: [String], medium: [String], hard: [String]) {
        self.id = UUID()
        self.theme = theme
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.id = try container.decode(FirebaseValue<UUID>.self, forKey: .id).value
        self.theme = try container.decode(FirebaseValue<String>.self, forKey: .theme).value
        
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
