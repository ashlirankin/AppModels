import Foundation

struct ThemePack: Sendable, Identifiable, Codable {
    let id: UUID
    let theme: String
    let easy: [String]
    let medium: [String]
    let hard: [String]
    
    init(theme: String, easy: [String], medium: [String], hard: [String]) {
        self.id = UUID()
        self.theme = theme
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
}
