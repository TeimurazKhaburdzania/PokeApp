//
//  PokemonDetailsViewModel.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

protocol PokemonDetailsViewModel {
    func getData()
}

class PokemonDetailsViewModelImpl {
    
    weak var view: PokemonDetailsView?
    let details: PokemonDetailsEntity
    
    init(details: PokemonDetailsEntity) {
        self.details = details
    }
}

extension PokemonDetailsViewModelImpl: PokemonDetailsViewModel {
    
    func getData() {
        let stats = details.stats.map { PokemonDetailStat(name: $0.stat.name, value: $0.baseStat) }
        let details = PokemonDetails(category: "geka", stats: stats, name: details.name, imageURLStr: details.sprites.other.home.frontDefault)
        view?.updateView(pokemonDetals: details)
    }
    
}
