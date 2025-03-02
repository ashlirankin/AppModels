import Foundation

/// Represents the current status of a waiting room.
/// Indicates whether players are waiting, matched, or if the game has started.
public enum RoomStatus: String, CaseIterable, Codable, Equatable, Sendable {
    /// Players are waiting for others to join
    case waiting
    /// Players have been matched and are ready
    case matched
    /// The game has started
    case gameStarted
    /// No active status (default state)
    case none
}

/// Defines the type of room players can join.
public enum RoomType: String, Codable, Equatable, Sendable {
    /// A room for quick matching with random players
    case quickMatch
    /// A private room that requires a code to join
    case privateRoom
    /// No room type specified (default state)
    case none
}

/// Represents a waiting room where players gather before starting a game.
/// This struct manages the room's state, players, and game association.
public struct WaitingRoom: Codable, Identifiable, Equatable, Sendable {
    
    /// Keys used for encoding and decoding waiting room data to/from Firebase.
    enum CodingKeys: CodingKey {
        /// The unique identifier for the room
        case id
        /// The room's access code
        case code
        /// When the room was created
        case createdAt
        /// The players in the room
        case players
        /// The current status of the room
        case status
        /// The associated game ID
        case gameId
        /// The type of room
        case roomType
    }
    
    /// The unique identifier for this waiting room.
    public let id: String
    
    /// The access code used to join this room.
    public let code: String
    
    /// The timestamp when this room was created.
    public let createdAt: Date
    
    /// The list of players currently in the room.
    public let players: [Player]
    
    /// The current status of the room.
    public let status: RoomStatus
    
    /// The ID of the associated game, if one exists.
    public let gameId: String?
    
    /// The type of this waiting room.
    public let roomType: RoomType
    
    /// Creates a new waiting room instance.
    /// - Parameters:
    ///   - id: The unique identifier for the room
    ///   - code: The access code for the room
    ///   - createdAt: When the room was created
    ///   - players: The initial list of players
    ///   - status: The initial room status
    ///   - gameId: The associated game ID, if any
    ///   - roomType: The type of room
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
