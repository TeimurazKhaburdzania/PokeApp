//
//  PokemonsViewModel.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

protocol PokemonsViewModel {
    func fetchPokemons()
    func getPokemonsCount() -> Int
    func getPokemon(for index: Int) -> Pokemon
    func didScrollToBottom()
    func didSelectItem(at index: Int)
    func fetchImage(index: Int)
}

class PokemonsViewModelImpl {
    
    weak var view: PokemonsView?
    let gateway: PokemonsGateway

    var pokemons: [Pokemon] = []
    var offset: Int { pokemons.count }
    var isLoading = false
    var pokemonDetailEntities: [String : PokemonDetailsEntity] = [:]
    
    
    init(gateway: PokemonsGateway) {
        self.gateway = gateway
    }


    func fetchPokemons() {
        gateway.fetchPokemons(limit: 40, offset: offset) { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let entity):
                    self?.handlePokemonsResponse(entity)
                case .failure(let error):
                    self?.view?.showAlert(text: error.localizedDescription)
                }
        }
    }
    func fetchImage(index: Int) {
        let name = pokemons[index].name
        guard pokemonDetailEntities[name] == nil else { return }
        gateway.fetchPokemonDetails(name: name) { [weak self] result in
            switch result {
            case .success(let entity):
                self?.pokemonDetailEntities[name] = entity
                self?.pokemons[index].imageURLStr = entity.sprites.other.home.frontDefault
                self?.view?.reloadRow(at: index)
            case .failure(let error):
                self?.view?.showAlert(text: error.localizedDescription)
            }
        }
    }
    
    func handlePokemonsResponse(_ entity: PokemonsResponseEntity) {
        self.pokemons += entity.results.enumerated().map {
            return .init(name: $1.name, imageURLStr: "")
        }
        self.view?.reloadData()
    }
    
    func didScrollToBottom() {
        if !isLoading {
            isLoading = true
            fetchPokemons()
        }
    }
}

extension PokemonsViewModelImpl: PokemonsViewModel {
    
    func didSelectItem(at index: Int) {
        let pokemon = pokemons[index]
        guard let details = pokemonDetailEntities[pokemon.name] else { return }
        let detailsVM = PokemonDetailsViewModelImpl(details: details)
        let detailsVC = PokemonDetailsViewController(viewModel: detailsVM)
        detailsVM.view = detailsVC
        view?.showVC(vc: detailsVC)
    }
    
    func getPokemonsCount() -> Int {
        pokemons.count
    }
    
    func getPokemon(for index: Int) -> Pokemon {
        pokemons[index]
    }
}
