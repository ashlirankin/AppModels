import SwiftUI

public enum GameMode {
    case singlePlayer
    case multiplayer(MultiplayerGameState)
}
