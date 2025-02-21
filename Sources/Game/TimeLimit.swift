//
//  TimeLimit.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//

import Foundation

public enum TimeLimit: Int, CaseIterable {
    case oneMinute = 60
    case threeMinutes = 180
    case fiveMinutes = 300
    
    var title: String {
        switch self {
        case .oneMinute: return "1 Minute"
        case .threeMinutes: return "3 Minutes"
        case .fiveMinutes: return "5 Minutes"
        }
    }
    
    var description: String {
        switch self {
        case .oneMinute: return "Quick challenge"
        case .threeMinutes: return "Balanced gameplay"
        case .fiveMinutes: return "Relaxed pace"
        }
    }
    
    var icon: String {
        switch self {
        case .oneMinute: return "timer"
        case .threeMinutes: return "timer.circle"
        case .fiveMinutes: return "timer.circle.fill"
        }
    }
}
