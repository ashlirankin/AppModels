import Foundation

public struct ThemePack: Sendable, Identifiable, Codable {
    public let id: UUID
    public let theme: String
    public let easy: [String]
    public let medium: [String]
    public let hard: [String]
    
    public init(theme: String, easy: [String], medium: [String], hard: [String]) {
        self.id = UUID()
        self.theme = theme
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
}
