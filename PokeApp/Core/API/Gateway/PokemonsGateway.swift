//
//  PokemonsGateway.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

protocol PokemonsGateway {
    func fetchPokemons(limit: Int, offset: Int, completionHandler: @escaping (Result<PokemonsResponseEntity, Error>) -> Void)
    func fetchPokemonDetails(name: String, completionHandler: @escaping (Result<PokemonDetailsEntity, Error>) -> Void)
}

class PokemonsGatewayImpl: BaseGateway, PokemonsGateway {
    
    func fetchPokemons(limit: Int, offset: Int, completionHandler: @escaping (Result<PokemonsResponseEntity, Error>) -> Void) {
        let urlStr = Constants.API.baseURL + "/pokemon"
        let queryItems: [URLQueryItem] = [.init(name: "limit", value: limit.description),
                                          .init(name: "offset", value: offset.description)]
        fetch(urlStr: urlStr, queryItems: queryItems, completionHandler: completionHandler)
    }
    
    func fetchPokemonDetails(name: String, completionHandler: @escaping (Result<PokemonDetailsEntity, Error>) -> Void) {
        let urlStr = Constants.API.baseURL + "/pokemon" + "/\(name)"
        fetch(urlStr: urlStr, completionHandler: completionHandler)
    }
}
