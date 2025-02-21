import Foundation
import SwiftUI

struct MultiplayerGameState: Codable {
    struct Player: Codable, Identifiable, Equatable {
        let id: UUID
        var name: String
        var score: Int
        var foundWords: Set<FoundWord>
        var currentSelection: [SharedGridPosition]
        var currentWord: String
        var color: Color
        
        static func == (lhs: Player, rhs: Player) -> Bool {
            lhs.id == rhs.id
        }
        
        enum CodingKeys: String, CodingKey {
            case id, name, score, foundWords, currentSelection, currentWord
            // Color will be handled separately since it's not Codable
        }
        
        init(id: UUID = UUID(), name: String, score: Int = 0, foundWords: Set<FoundWord> = [], currentSelection: [SharedGridPosition] = [], currentWord: String = "", color: Color) {
            self.id = id
            self.name = name
            self.score = score
            self.foundWords = foundWords
            self.currentSelection = currentSelection
            self.currentWord = currentWord
            self.color = color
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            score = try container.decode(Int.self, forKey: .score)
            foundWords = try container.decode(Set<FoundWord>.self, forKey: .foundWords)
            currentSelection = try container.decode([SharedGridPosition].self, forKey: .currentSelection)
            currentWord = try container.decode(String.self, forKey: .currentWord)
            // Default color will be set by the game
            color = .blue
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(score, forKey: .score)
            try container.encode(foundWords, forKey: .foundWords)
            try container.encode(currentSelection, forKey: .currentSelection)
            try container.encode(currentWord, forKey: .currentWord)
            // Color is not encoded since it's not Codable
        }
    }
    
    enum GameStatus: String, Codable {
        case waiting     // Waiting for players to join
        case starting    // Game is about to start (countdown)
        case playing     // Game is in progress
        case paused     // Game is temporarily paused
        case finished   // Game has ended
    }
    
    var players: [Player]
    var currentTurn: UUID
    var gameStatus: GameStatus
    var timeRemaining: Int
    var maxPlayers: Int
    var minPlayers: Int
    var gameStartTime: Date?
    var gameDuration: Int // in seconds
    var hostId: UUID
    var roomCode: String
    
    init(
        players: [Player] = [],
        currentTurn: UUID = UUID(),
        gameStatus: GameStatus = .waiting,
        timeRemaining: Int = 180,
        maxPlayers: Int = 4,
        minPlayers: Int = 2,
        gameStartTime: Date? = nil,
        gameDuration: Int = 180,
        hostId: UUID = UUID(),
        roomCode: String = ""
    ) {
        self.players = players
        self.currentTurn = currentTurn
        self.gameStatus = gameStatus
        self.timeRemaining = timeRemaining
        self.maxPlayers = maxPlayers
        self.minPlayers = minPlayers
        self.gameStartTime = gameStartTime
        self.gameDuration = gameDuration
        self.hostId = hostId
        self.roomCode = roomCode
    }
    
    var canStart: Bool {
        players.count >= minPlayers && gameStatus == .waiting
    }
    
    var canJoin: Bool {
        players.count < maxPlayers && gameStatus == .waiting
    }
    
    var isFinished: Bool {
        gameStatus == .finished || timeRemaining <= 0
    }
    
    mutating func addPlayer(_ player: Player) -> Bool {
        guard canJoin else { return false }
        players.append(player)
        return true
    }
    
    mutating func removePlayer(_ playerId: UUID) {
        players.removeAll { $0.id == playerId }
        if players.isEmpty {
            gameStatus = .finished
        } else if players.count < minPlayers {
            gameStatus = .waiting
        }
    }
    
    mutating func startGame() {
        guard canStart else { return }
        gameStatus = .playing
        gameStartTime = Date()
        timeRemaining = gameDuration
    }
    
    mutating func updateTimeRemaining() {
        guard gameStatus == .playing,
              let startTime = gameStartTime else { return }
        
        let elapsed = Int(Date().timeIntervalSince(startTime))
        timeRemaining = max(0, gameDuration - elapsed)
        
        if timeRemaining <= 0 {
            gameStatus = .finished
        }
    }
} 
