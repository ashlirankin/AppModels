import Foundation

public enum RoomStatus: String, CaseIterable, Codable, Equatable, Sendable {
    case waiting
    case matched
    case gameStarted
    case none
}

public enum RoomType: String, Codable, Equatable, Sendable {
    case quickMatch
    case privateRoom
    case none
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
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let playersContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        let arrayContainer = try playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        self.players = try arrayContainer.decode([Player].self, forKey: .values)
    
        self.id = try container.decode(FirebaseValue<String>.self, forKey: .id).value
        self.code = try container.decode(FirebaseValue<String>.self, forKey: .code).value
        self.createdAt = try container.decode(FirebaseValue<Date>.self, forKey: .createdAt).value
        
        let statusString = try container.decode(FirebaseValue<String>.self, forKey: .status).value
        self.status = RoomStatus(rawValue: statusString) ?? RoomStatus.none
        
        let roomTypeString = try container.decode(FirebaseValue<String>.self, forKey: .roomType).value
        self.roomType = RoomType(rawValue: roomTypeString) ?? RoomType.none
        
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
        try container.encode(FirebaseValue(value: status.rawValue), forKey: .status)
        try container.encode(FirebaseValue(value: roomType.rawValue), forKey: .roomType)
       
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
