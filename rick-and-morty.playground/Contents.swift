import UIKit

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}

let url = URL(string: "https://rickandmortyapi.com/api/character/2")

func fetchCharacter() async -> Character? {
    guard let url = url else {
        return nil
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let character = try JSONDecoder().decode(Character.self, from: data)
        
        return character
    } catch {
        return nil
    }
}

    Task {
        let character = await fetchCharacter()
        
        print(character?.name)
    }



