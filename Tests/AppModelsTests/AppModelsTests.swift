import Testing
import Foundation
@testable import AppModels

@Suite("Endcoding Tests")
struct EncodingTests {
    
    @Test("User")
    func encodeUser() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        let user = User(id: "1", name: "Jane Doe")
        let data = try! encoder.encode(user)
        let str = String(data: data, encoding: .utf8)!
        print(str)
    }
    
    @Test("Waiting Room")
    func encodeWaitingRoom() async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        let playerOne = Player(user: .init(id: "1", name: "Jane Doe"), joinedAt: .now, isHost: true)
        let waitingRoom = WaitingRoom(id: "1", code: "1234", createdAt: Date(), players: [playerOne], status: "waiting", gameId: nil, roomType: "quickMatch")
        
        let data = try! encoder.encode(waitingRoom)
        let str = String(data: data, encoding: .utf8)!
        print(str)
    }
}

@Suite("Decoding Tests")
struct DecodingTests {
    
    @Test("User")
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

    @Test("Waiting Room")
    func decodeWaitingRoom() async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        let playerOne = Player(user: .init(id: "1", name: "Jane Doe"), joinedAt: .now, isHost: true)
        let waitingRoom = WaitingRoom(id: "1", code: "1234", createdAt: Date(), players: [playerOne], status: "waiting", gameId: nil, roomType: RoomType.quickMatch.rawValue)
        
        let data = try! encoder.encode(waitingRoom)
        let decoder = JSONDecoder()
        let decodedWaitingRoom = try! decoder.decode(WaitingRoom.self, from: data)
        
        #expect(decodedWaitingRoom.status == "waiting")
        #expect(decodedWaitingRoom.id == "1")
    }
    
    @Test("Theme Pack")
    func decodeThemePack() async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        let themePack = ThemePack(theme: "Hello World", easy: ["Coding is fun"], medium: ["Swift", "Python"], hard: ["Computer Sciend"])
        
        let data = try! encoder.encode(themePack)
        
        let decoder = JSONDecoder()
        let decodedThemePack = try! decoder.decode(ThemePack.self, from: data)
        
        #expect(decodedThemePack.theme == "Hello World")
    }
}
    
