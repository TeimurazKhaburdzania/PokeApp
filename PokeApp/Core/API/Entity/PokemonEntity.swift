//
//  PokemonEntity.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

struct PokemonsResponseEntity: Decodable {
    let results: [PokemonEntity]
}

struct PokemonEntity: Decodable {
    let name: String
    let url: String
}
