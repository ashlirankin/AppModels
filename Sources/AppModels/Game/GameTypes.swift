import Foundation

public enum GameMode {
    case singlePlayer
    case multiplayer(MultiplayerGameState)
}
