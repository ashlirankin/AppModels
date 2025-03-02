import Foundation

/// Represents the available game modes in the word search game.
/// This enum distinguishes between single player and multiplayer gameplay experiences.
public enum GameMode {
    /// Single player mode where one player solves the puzzle alone
    case singlePlayer
    
    /// Multiplayer mode with associated game state information
    /// - Parameter state: The current state of the multiplayer game
    case multiplayer(MultiplayerGameState)
}
