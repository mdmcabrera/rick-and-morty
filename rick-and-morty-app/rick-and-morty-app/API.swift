//
//  API.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 03/02/2022.
//

import Foundation
import RealmSwift

enum Endpoint: String {
    case allCharacters = "https://rickandmortyapi.com/api/character"
}


func fetchCharacters() async -> List<Character>? {
    let url = URL(string: Endpoint.allCharacters.rawValue)
    guard let url = url else {
        return nil
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)

        let decodedData = try JSONDecoder().decode(ResponseInfo.self, from: data)
        let characters = decodedData.results
        
         return characters
    } catch {
        return nil
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
