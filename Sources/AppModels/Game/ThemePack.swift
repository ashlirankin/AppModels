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
    public let theme: StringValue
    public let easy: [String]
    public let medium: [String]
    public let hard: [String]
    
    public init(theme: StringValue, easy: [String], medium: [String], hard: [String]) {
        self.id = UUID()
        self.theme = theme
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        self.id = try idContainer.decode(UUID.self, forKey: .stringValue)
        
        var themeContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .theme)
        self.theme = try themeContainer.decode(StringValue.self, forKey: .stringValue)
        
        var easyContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .easy)
        var arrayContainer = try easyContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.easy = try arrayContainer.decode([String].self, forKey: .values)
       
        var mediumContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        var mediumArrayContainer = try mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.medium = try mediumArrayContainer.decode([String].self, forKey: .values)
       
        var hardContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        var hardArrayContainer = try hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.hard = try hardArrayContainer.decode([String].self, forKey: .values)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
        
        var themeContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .theme)
        try themeContainer.encode(theme, forKey: .stringValue)
       
        var easyContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .easy)
        var arrayEasyContainer = easyContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        try arrayEasyContainer.encode(easy, forKey: .values)
        
        
        var mediumContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        var mediumArrayEasyContainer = mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        try mediumArrayEasyContainer.encode(medium, forKey: .values)
        
        var hardContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        var hardArrayEasyContainer = hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        try hardArrayEasyContainer.encode(hard, forKey: .values)
    }
}
