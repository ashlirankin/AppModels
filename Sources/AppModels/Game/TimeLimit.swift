//
//  TimeLimit.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//

import Foundation

/// Represents the available time limits for word search puzzles.
/// Each case provides a different duration and gameplay experience.
public enum TimeLimit: Int, CaseIterable {
    /// A one-minute time limit for quick, intense gameplay
    case oneMinute = 60
    
    /// A three-minute time limit for standard gameplay
    case threeMinutes = 180
    
    /// A five-minute time limit for relaxed gameplay
    case fiveMinutes = 300
    
    /// A user-friendly title for the time limit option.
    public var title: String {
        switch self {
        case .oneMinute: return "1 Minute"
        case .threeMinutes: return "3 Minutes"
        case .fiveMinutes: return "5 Minutes"
        }
    }
    
    /// A description of the gameplay experience for this time limit.
    public var description: String {
        switch self {
        case .oneMinute: return "Quick challenge"
        case .threeMinutes: return "Balanced gameplay"
        case .fiveMinutes: return "Relaxed pace"
        }
    }
    
    /// The SF Symbol icon name associated with this time limit.
    public var icon: String {
        switch self {
        case .oneMinute: return "timer"
        case .threeMinutes: return "timer.circle"
        case .fiveMinutes: return "timer.circle.fill"
        }
    }
}
