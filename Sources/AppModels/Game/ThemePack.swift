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
    public let easy: [StringValue]
    public let medium: [StringValue]
    public let hard: [StringValue]
    
    public init(theme: StringValue, easy: [StringValue], medium: [StringValue], hard: [StringValue]) {
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
        var valuesContainer = try arrayContainer.nestedUnkeyedContainer(forKey: .values)
        self.easy = try valuesContainer.decode([StringValue].self)
       
        var mediumContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        var mediumArrayContainer = try mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var mediumValuesContainer = try mediumArrayContainer.nestedUnkeyedContainer(forKey: .values)
        self.medium = try mediumValuesContainer.decode([StringValue].self)
       
        var hardContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        var hardArrayContainer = try hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var hardValuesContainer = try hardArrayContainer.nestedUnkeyedContainer(forKey: .values)
        self.hard = try hardValuesContainer.decode([StringValue].self)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
        
        var themeContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .theme)
        try themeContainer.encode(theme, forKey: .stringValue)
       
        var easyContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .easy)
        var arrayEasyContainer = easyContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var valuesContainer = arrayEasyContainer.nestedUnkeyedContainer(forKey: .values)
        try valuesContainer.encode(contentsOf: easy)
        
        
        var mediumContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .medium)
        var mediumArrayEasyContainer = mediumContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var mediumValuesContainer = arrayEasyContainer.nestedUnkeyedContainer(forKey: .values)
        try mediumValuesContainer.encode(contentsOf: medium)
       
        var hardContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .hard)
        var hardArrayEasyContainer = hardContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var hardValuesContainer = hardArrayEasyContainer.nestedUnkeyedContainer(forKey: .values)
        try hardValuesContainer.encode(contentsOf: hard)
    }
}
