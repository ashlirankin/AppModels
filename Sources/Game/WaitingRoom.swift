import Foundation

struct WaitingRoom: Codable, Identifiable, Equatable {
    let id: String
    let code: String
    let createdAt: Date
    let players: [Player]
    let status: RoomStatus
    let gameId: String?
    let roomType: RoomType
    
    enum RoomStatus: String, CaseIterable, Codable, Equatable {
        case waiting
        case matched
        case gameStarted
        
        func encode(to encoder: any Encoder) throws {
            let container = encoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = encoder.container(keyedBy: FirebaseDataTypes.self)
            try rawValueContainer.encode(rawValue, forKey: .stringValue)
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = try decoder.container(keyedBy: FirebaseDataTypes.self)
            self = try rawValueContainer.decode(Self.self, forKey: .stringValue)
        }
    }
    
    enum RoomType: String, Codable, Equatable {
        case quickMatch
        case privateRoom
        
        func encode(to encoder: any Encoder) throws {
            let container = encoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = encoder.container(keyedBy: FirebaseDataTypes.self)
            try rawValueContainer.encode(rawValue, forKey: .stringValue)
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var rawValueContainer = try decoder.container(keyedBy: FirebaseDataTypes.self)
            self = try rawValueContainer.decode(Self.self, forKey: .stringValue)
        }
    }
    
    func encode(to encoder: any Encoder) throws {
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
