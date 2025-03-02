import Foundation

public struct MultiplayerGameState: Codable {
    public enum GameStatus: String, Codable {
        case waiting     // Waiting for players to join
        case starting    // Game is about to start (countdown)
        case playing     // Game is in progress
        case paused     // Game is temporarily paused
        case finished   // Game has ended
    }
    
    public var players: [Player]
    public var currentTurn: UUID
    public var gameStatus: GameStatus
    public var timeRemaining: Int
    public var maxPlayers: Int
    public var minPlayers: Int
    public var gameStartTime: Date?
    public var gameDuration: Int // in seconds
    public var hostId: UUID
    public var roomCode: String
    
    public init(players: [Player] = [], currentTurn: UUID = UUID(),  gameStatus: GameStatus = .waiting, timeRemaining: Int = 180, maxPlayers: Int = 4, minPlayers: Int = 2, gameStartTime: Date? = nil, gameDuration: Int = 180, hostId: UUID = UUID(), roomCode: String = "") {
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
    
    public var canStart: Bool {
        players.count >= minPlayers && gameStatus == .waiting
    }
    
    public var canJoin: Bool {
        players.count < maxPlayers && gameStatus == .waiting
    }
    
    public var isFinished: Bool {
        gameStatus == .finished || timeRemaining <= 0
    }
    
    public mutating func addPlayer(_ player: Player) -> Bool {
        guard canJoin else { return false }
        players.append(player)
        return true
    }
    
    public mutating func removePlayer(_ playerId: UUID) {
        players.removeAll { $0.id == playerId.uuidString }
        if players.isEmpty {
            gameStatus = .finished
        } else if players.count < minPlayers {
            gameStatus = .waiting
        }
    }
    
    public mutating func startGame() {
        guard canStart else { return }
        gameStatus = .playing
        gameStartTime = Date()
        timeRemaining = gameDuration
    }
    
    public mutating func updateTimeRemaining() {
        guard gameStatus == .playing,
              let startTime = gameStartTime else { return }
        
        let elapsed = Int(Date().timeIntervalSince(startTime))
        timeRemaining = max(0, gameDuration - elapsed)
        
        if timeRemaining <= 0 {
            gameStatus = .finished
        }
    }
} 
