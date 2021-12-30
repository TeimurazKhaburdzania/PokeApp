//
//  PokemonDetails.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

class PokemonDetails: Pokemon {
    
    let category: String
    let stats: [PokemonDetailStat]
    
    init(category: String, stats: [PokemonDetailStat], name: String, imageURLStr: String) {
        self.category = category
        self.stats = stats
        super.init(name: name, imageURLStr: imageURLStr)
    }
}

struct PokemonDetailStat {
    let name: String
    let value: Int
}
