//
//  Player.swift
//  AppModels
//
//  Created by Ashli Rankin on 2/21/25.
//


import Foundation

public struct Player: Codable, Identifiable, Equatable, Sendable {
   
    enum CodingKeys: CodingKey {
        case user
        case joinedAt
        case isHost
    }
    
    public let user: User
    public let joinedAt: Date
    public let isHost: Bool
    
    public var id: String {
        return user.id
    }
    
    public init(user: User, joinedAt: Date, isHost: Bool) {
        self.user = user
        self.joinedAt = joinedAt
        self.isHost = isHost
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.user = try container.decode(User.self, forKey: .user)
        self.joinedAt = try container.decode(FirebaseValue<Date>.self, forKey: .joinedAt).value
        self.isHost = try container.decode(FirebaseValue<Bool>.self, forKey: .isHost).value
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(FirebaseValue(value: joinedAt), forKey: .joinedAt)
        try container.encode(FirebaseValue(value: isHost), forKey: .isHost)
        try container.encode(self.user, forKey: .user)
    }
}
