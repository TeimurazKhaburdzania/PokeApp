//
//  Constants.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

struct Constants {
    
    struct API {
        static let baseURL = ProcessInfo.processInfo.environment["BaseURL"] ?? ""
    }
}
