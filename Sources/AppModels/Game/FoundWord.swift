//
//  FoundWord.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import SwiftUI

public struct FoundWord: Codable, Hashable, Sendable {
    public let word: String
    public let positions: [SharedGridPosition]
    public let colorIndex: Int
    
    public var color: Color {
        FoundWord.colors[colorIndex % FoundWord.colors.count]
    }
    
    public static let colors: [Color] = [
        .green,
        .blue,
        .purple,
        .orange,
        .pink,
        .teal,
        .yellow,
        .mint
    ]
}
