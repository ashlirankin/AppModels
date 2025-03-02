import Foundation

public enum RoomStatus: String, CaseIterable, Codable, Equatable, Sendable {
    case waiting
    case matched
    case gameStarted
}

public enum RoomType: String, Codable, Equatable, Sendable {
    case quickMatch
    case privateRoom
}

public struct WaitingRoom: Codable, Identifiable, Equatable, Sendable {
    
    enum CodingKeys: CodingKey {
        case id
        case code
        case createdAt
        case players
        case status
        case gameId
        case roomType
    }
    
    public let id: String
    public let code: String
    public let createdAt: Date
    public let players: [Player]
    public let status: String
    public let gameId: String?
    public let roomType: String
    
    public init(id: String, code: String, createdAt: Date, players: [Player], status: String, gameId: String?, roomType: String) {
        self.id = id
        self.code = code
        self.createdAt = createdAt
        self.players = players
        self.status = status
        self.gameId = gameId
        self.roomType = roomType
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let playersContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        let arrayContainer = try playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.players = try arrayContainer.decode([Player].self, forKey: .values)
    
        self.id = try container.decode(FirebaseValue<String>.self, forKey: .id).value
        self.code = try container.decode(FirebaseValue<String>.self, forKey: .code).value
        self.createdAt = try container.decode(FirebaseValue<Date>.self, forKey: .createdAt).value
        self.status = try container.decode(FirebaseValue<String>.self, forKey: .status).value
        self.roomType = try container.decode(FirebaseValue<String>.self, forKey: .roomType).value
        
        if let gameIdPresent = try? container.decodeIfPresent(FirebaseValue<String>.self, forKey: .gameId)?.value {
            self.gameId = gameIdPresent
        } else {
            self.gameId = nil
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(FirebaseValue(value: id), forKey: .id)
        try container.encode(FirebaseValue(value: code), forKey: .code)
        try container.encode(FirebaseValue(value: createdAt), forKey: .createdAt)
        try container.encode(FirebaseValue(value: status), forKey: .status)
        try container.encode(FirebaseValue(value: roomType), forKey: .roomType)
       
        var playersContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        var valuesContainer = playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        try valuesContainer.encode(players, forKey: .values)
        
        if let gameId = gameId {
            try container.encode(FirebaseValue(value: gameId), forKey: .gameId)
        } else {
            var gameIdContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .gameId)
            try gameIdContainer.encodeNil(forKey: .nullValue)
        }
    }
}
