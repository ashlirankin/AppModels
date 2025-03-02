//
//  Difficulty.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import Foundation

public enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    public var icon: String {
        switch self {
        case .easy: return "star"
        case .medium: return "star.fill"
        case .hard: return "dumbbell.fill"
        }
    }
    
    public var description: String {
        switch self {
        case .easy: return "Perfect for beginners"
        case .medium: return "A balanced challenge"
        case .hard: return "Test your skills"
        }
    }
}
