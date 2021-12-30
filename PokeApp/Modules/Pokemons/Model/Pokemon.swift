//
//  Pokemon.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

class Pokemon {
    
    let name: String
    var imageURLStr: String
    
    init(name: String, imageURLStr: String) {
        self.name = name
        self.imageURLStr = imageURLStr
    }
}
