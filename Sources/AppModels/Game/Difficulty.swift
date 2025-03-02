//
//  Difficulty.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//

import Foundation

/// Represents the difficulty levels available in the game.
/// Each level provides a different gaming experience suitable for various player skill levels.
public enum Difficulty: String, CaseIterable, Codable {
    /// The easiest difficulty level, suitable for new players
    case easy = "Easy"
    
    /// A moderate difficulty level that provides a balanced challenge
    case medium = "Medium"
    
    /// The most challenging difficulty level for experienced players
    case hard = "Hard"
    
    /// The SF Symbol icon name associated with each difficulty level.
    public var icon: String {
        switch self {
        case .easy: return "star"
        case .medium: return "star.fill"
        case .hard: return "dumbbell.fill"
        }
    }
    
    /// A user-friendly description of what to expect from each difficulty level.
    public var description: String {
        switch self {
        case .easy: return "Perfect for beginners"
        case .medium: return "A balanced challenge"
        case .hard: return "Test your skills"
        }
    }
}
