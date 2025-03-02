import Foundation

public struct WaitingRoom: Codable, Identifiable, Equatable, Sendable {
    
    public enum RoomStatus: String, CaseIterable, Codable, Equatable, Sendable {
        case waiting
        case matched
        case gameStarted
    }
    
    public enum RoomType: String, Codable, Equatable, Sendable {
        case quickMatch
        case privateRoom
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
        
        var idContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        self.id = try idContainer.decode(String.self, forKey: .stringValue)
        
        let codeContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .code)
        self.code = try codeContainer.decode(String.self, forKey: .stringValue)
       
        let createdAtContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .createdAt)
        self.createdAt = try createdAtContainer.decode(Date.self, forKey: .timestampValue)
       
        
        let playersContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        let arrayContainer = try playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var valuesArray = try arrayContainer.nestedUnkeyedContainer(forKey: .values)
        
        self.players = [try valuesArray.decode(Player.self)]
        
        var gameIdContainer = try container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .gameId)
        self.gameId = try gameIdContainer.decode(String.self, forKey: .stringValue)
       
        self.status = try container.decode(String.self, forKey: .status)
        self.roomType = try container.decode(String.self, forKey: .roomType)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var idContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .id)
        try idContainer.encode(id, forKey: .stringValue)
       
        var codeContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .code)
        try codeContainer.encode(code, forKey: .stringValue)
        
        var createdAtContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .createdAt)
        try createdAtContainer.encode(createdAt, forKey: .timestampValue)

        var playersContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .players)
        var valuesContainer = playersContainer.nestedContainer(keyedBy: SupplementaryCodingKeys.self, forKey: .arrayValue)
        var arrayContainer = valuesContainer.nestedUnkeyedContainer(forKey: .values)
        try arrayContainer.encode(players)
        
        var nestedStatusContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .status)
        try nestedStatusContainer.encode(status, forKey: .stringValue)
        
        var nestedRoomTypeContainer = container.nestedContainer(keyedBy: FirebaseDataTypes.self, forKey: .roomType)
        try nestedRoomTypeContainer.encode(roomType, forKey: .stringValue)
    }
}
