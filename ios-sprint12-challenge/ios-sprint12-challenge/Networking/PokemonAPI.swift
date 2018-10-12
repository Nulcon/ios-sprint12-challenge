//
//  PokemonAPI.swift
//  ios-sprint12-challenge
//
//  Created by Conner on 10/12/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

@objc class PokemonAPI: NSObject {
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
                guard let dictionary = (try JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                        completion(nil, NSError())
                        return
                }
                print(pokemonDictionaries)
                
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
}
