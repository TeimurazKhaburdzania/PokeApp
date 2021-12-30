//
//  PokemonDetailsEntity.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

struct PokemonDetailsEntity: Decodable {
    let name: String
    let sprites: PokemonDetailsSpritesEntity
    let stats: [PokemonDetailsStatDataEntity]
}

struct PokemonDetailsSpritesEntity: Decodable {
    let other: PokemonDetailsOtherSpritesEntity
}

struct PokemonDetailsOtherSpritesEntity: Decodable {
    let home: PokemonDetailsOtherSpritesHomeEntity
}

struct PokemonDetailsOtherSpritesHomeEntity: Decodable {
    let frontDefault: String
}

struct PokemonDetailsStatDataEntity: Decodable {
    let baseStat: Int
    let stat: PokemonDetailsStatEntity
}

struct PokemonDetailsStatEntity: Decodable {
    let name: String
}
