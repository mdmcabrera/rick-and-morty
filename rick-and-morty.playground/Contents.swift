import UIKit

// Data to get paginated response
struct ResponseInfo: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

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

let url = URL(string: "https://rickandmortyapi.com/api/character")

/*
 Fetch 20 first characters
 */
func fetchCharacter() async -> [Character] {
    guard let url = url else {
        return []
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedData = try JSONDecoder().decode(ResponseInfo.self, from: data)
        let characters = decodedData.results
        
        return characters
    } catch {
        return []
    }
}
/*
 Fetch character by id
 */
func fetchCharacter(id: Int) async -> Character? {
    let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")
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
        let characters = await fetchCharacter()
        for character in characters {
         //   print(character.name)
        }

        let character = await fetchCharacter(id: 4)
        print(character?.name)
    }



