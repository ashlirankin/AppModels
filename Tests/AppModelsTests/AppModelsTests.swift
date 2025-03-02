import Testing
import Foundation
@testable import AppModels

@Test("Encode User")
func encodeUser() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let user = User(id: "1", name: "Jane Doe")
    let data = try! encoder.encode(user)
    let str = String(data: data, encoding: .utf8)!
    print(str)
}

@Test("Decode User")
func decodeUser() async throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let user = User(id: "1", name: "Jane Doe")
    let data = try! encoder.encode(user)
    
    let decoder = JSONDecoder()
    let decodedUser = try! decoder.decode(User.self, from: data)
    
    #expect(decodedUser.id == "1")
    #expect(decodedUser.name == "Jane Doe")
}

@Test("Encode Waiting Room")
func encodeWaitingRoom() async throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let playerOne = Player(user: .init(id: "1", name: "Jane Doe"), joinedAt: .now, isHost: true)
    let waitingRoom = WaitingRoom(id: "1", code: "1234", createdAt: Date(), players: [playerOne], status: "waiting", gameId: nil, roomType: "quickMatch")
    
    let data = try! encoder.encode(waitingRoom)
    let str = String(data: data, encoding: .utf8)!
    print(str)
}

@Test("Decode Waiting Room")
func decodeWaitingRoom() async throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let playerOne = Player(user: .init(id: "1", name: "Jane Doe"), joinedAt: .now, isHost: true)
    let waitingRoom = WaitingRoom(id: "1", code: "1234", createdAt: Date(), players: [playerOne], status: "waiting", gameId: nil, roomType: WaitingRoom.RoomType.quickMatch.rawValue)
    
    let data = try! encoder.encode(waitingRoom)
    let str = String(data: data, encoding: .utf8)!
    
    let decoder = JSONDecoder()
    let decodedUser = try! decoder.decode(WaitingRoom.self, from: data)
}

