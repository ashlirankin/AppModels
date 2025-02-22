//
//  Difficulty.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import SwiftUI

public enum Difficulty: String, CaseIterable, Codable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        
        public var color: Color {
            switch self {
            case .easy: return .green
            case .medium: return .orange
            case .hard: return .red
            }
        }
        
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
        
    public func gridSize(deviceType: UIUserInterfaceIdiom) -> Int {
        let isPhone = deviceType == .phone
        
        switch self {
        case .easy:
            return 8    // 8x8 grid for all devices
        case .medium:
            return isPhone ? 9 : 10  // 9x9 for phones, 10x10 for iPads
        case .hard:
            return isPhone ? 12 : 16  // 12x12 for phones, 16x16 for iPads
        }
    }
    
    public func gridDescription(deviceType: UIUserInterfaceIdiom) -> String {
        return "\(gridSize(deviceType: deviceType))×\(String(describing: gridSize)) Grid"
    }
}
