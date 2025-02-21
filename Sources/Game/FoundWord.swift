//
//  FoundWord.swift
//  WordSearch
//
//  Created by Ashli Rankin on 2/16/25.
//


import SwiftUI

struct FoundWord: Codable, Hashable {
    let word: String
    let positions: [SharedGridPosition]
    let colorIndex: Int
    
    var color: Color {
        FoundWord.colors[colorIndex % FoundWord.colors.count]
    }
    
    static let colors: [Color] = [
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
