import Foundation

public struct WaitingRoom: Codable, Identifiable, Equatable {
    public let id: String
    public let code: String
    public let createdAt: Date
    public let players: [Player]
    public let status: RoomStatus
    public let gameId: String?
    public let roomType: RoomType
    
    public enum RoomStatus: String, CaseIterable, Codable, Equatable {
        case waiting
        case matched
        case gameStarted
        
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .status)
            try rawValueContainer.encode(rawValue, forKey: .stringValue)
        }
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValueContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .status)
            self = try rawValueContainer.decode(Self.self, forKey: .stringValue)
        }
    }
    
    public enum RoomType: String, Codable, Equatable {
        case quickMatch
        case privateRoom
        
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .roomType)
            try rawValueContainer.encode(rawValue, forKey: .stringValue)
        }
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValueContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .roomType)
            self = try rawValueContainer.decode(Self.self, forKey: .stringValue)
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
       
        var codeContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .code)
        try codeContainer.encode(code, forKey: .stringValue)
        
        var createdAtContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .code)
        try createdAtContainer.encode(createdAt, forKey: .timestampValue)

        var playersContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        var arrayContainer = playersContainer.nestedUnkeyedContainer(forKey: .arrayValue)
        try arrayContainer.encode(players)
        
        try container.encode(status, forKey: .status)
        
        var gameIdContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try gameIdContainer.encodeIfPresent(gameId, forKey: .stringValue)
        
        try container.encode(roomType, forKey: .roomType)
    }
}
