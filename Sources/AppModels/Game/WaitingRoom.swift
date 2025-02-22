import Foundation

public struct WaitingRoom: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let code: String
    public let createdAt: Date
    public let players: [Player]
    public let status: RoomStatus
    public let gameId: String?
    public let roomType: RoomType
    
    public init(id: String, code: String, createdAt: Date, players: [Player], status: RoomStatus, gameId: String?, roomType: RoomType) {
        self.id = id
        self.code = code
        self.createdAt = createdAt
        self.players = players
        self.status = status
        self.gameId = gameId
        self.roomType = roomType
    }
    
    public enum RoomStatus: String, CaseIterable, Codable, Equatable, Sendable {
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
    
    public enum RoomType: String, Codable, Equatable, Sendable {
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
    
    enum CodingKeys: CodingKey {
        case id
        case code
        case createdAt
        case players
        case status
        case gameId
        case roomType
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        self.id = try idContainer.decode(String.self, forKey: .stringValue)
        
        var codeContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .code)
        self.code = try codeContainer.decode(String.self, forKey: .stringValue)
       
        var createdAtContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .createdAt)
        self.createdAt = try createdAtContainer.decode(Date.self, forKey: .timestampValue)
       
        var playersContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        var arrayContainer = try playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var valuesContainer = try arrayContainer.nestedUnkeyedContainer(forKey: .values)
        self.players = try valuesContainer.decode([Player].self)
        
        var gameIdContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .gameId)
        self.gameId = try gameIdContainer.decode(String.self, forKey: .stringValue)
       
        self.status = try container.decode(WaitingRoom.RoomStatus.self, forKey: .status)
        self.roomType = try container.decode(WaitingRoom.RoomType.self, forKey: .roomType)
    }
}
