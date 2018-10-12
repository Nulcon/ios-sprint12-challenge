//
//  PokemonAPI.swift
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonAPI: NSObject {
    @objc static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([CGAPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            do {
                guard let dictionary = (try JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String: Any]] else {
                        completion(nil, NSError())
                        return
                }
                let pokemon = pokemonDictionaries.compactMap { CGAPokemon(dictionary: $0) }
                completion(pokemon, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: CGAPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name.lowercased())

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error GET pokemon: \(error)")
                return
            }

            guard let data = data else { return }

            do {
                guard let dictionary = (try JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any],
                    let pokemonAbilities = dictionary["abilities"] as? [[String: Any]],
                    let pokemonSprites = dictionary["sprites"] as? [String : Any],
                    let pokemonIdentifier = dictionary["id"] as? NSNumber else {
                    return
                }

                pokemon.abilities = pokemonAbilities
                pokemon.identifier = pokemonIdentifier
//                pokemon.sprite = pokemonSprites["front_default"]
            } catch {
                return
            }
        }.resume()
    }
}
