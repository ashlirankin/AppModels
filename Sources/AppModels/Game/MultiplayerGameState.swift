import Foundation

/// Represents the current state of a multiplayer word search game.
/// This struct manages the game's lifecycle, players, and timing.
public struct MultiplayerGameState: Codable {
    /// Represents the different states a multiplayer game can be in.
    public enum GameStatus: String, Codable {
        /// Waiting for players to join the game
        case waiting
        /// Game is about to start (countdown phase)
        case starting
        /// Game is actively being played
        case playing
        /// Game is temporarily paused
        case paused
        /// Game has concluded
        case finished
    }
    
    /// The list of players currently in the game.
    public var players: [Player]
    
    /// The ID of the player whose turn it currently is.
    public var currentTurn: UUID
    
    /// The current status of the game.
    public var gameStatus: GameStatus
    
    /// The number of seconds remaining in the current game.
    public var timeRemaining: Int
    
    /// The maximum number of players allowed in the game.
    public var maxPlayers: Int
    
    /// The minimum number of players required to start the game.
    public var minPlayers: Int
    
    /// The time when the game started, if it has begun.
    public var gameStartTime: Date?
    
    /// The total duration of the game in seconds.
    public var gameDuration: Int
    
    /// The ID of the player hosting the game.
    public var hostId: UUID
    
    /// A unique code that identifies this game room.
    public var roomCode: String
    
    /// Creates a new multiplayer game state with the specified parameters.
    public init(players: [Player] = [], 
                currentTurn: UUID = UUID(),  
                gameStatus: GameStatus = .waiting, 
                timeRemaining: Int = 180, 
                maxPlayers: Int = 4, 
                minPlayers: Int = 2, 
                gameStartTime: Date? = nil, 
                gameDuration: Int = 180, 
                hostId: UUID = UUID(), 
                roomCode: String = "") {
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
    
    /// Indicates whether the game has enough players and is ready to start.
    public var canStart: Bool {
        players.count >= minPlayers && gameStatus == .waiting
    }
    
    /// Indicates whether new players can join the game.
    public var canJoin: Bool {
        players.count < maxPlayers && gameStatus == .waiting
    }
    
    /// Indicates whether the game has finished.
    public var isFinished: Bool {
        gameStatus == .finished || timeRemaining <= 0
    }
    
    /// Attempts to add a new player to the game.
    /// - Parameter player: The player to add
    /// - Returns: True if the player was successfully added, false otherwise
    public mutating func addPlayer(_ player: Player) -> Bool {
        guard canJoin else { return false }
        players.append(player)
        return true
    }
    
    /// Removes a player from the game.
    /// - Parameter playerId: The ID of the player to remove
    public mutating func removePlayer(_ playerId: UUID) {
        players.removeAll { $0.id == playerId.uuidString }
        if players.isEmpty {
            gameStatus = .finished
        } else if players.count < minPlayers {
            gameStatus = .waiting
        }
    }
    
    /// Starts the game if conditions are met.
    public mutating func startGame() {
        guard canStart else { return }
        gameStatus = .playing
        gameStartTime = Date()
        timeRemaining = gameDuration
    }
    
    /// Updates the remaining time based on elapsed time since game start.
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
