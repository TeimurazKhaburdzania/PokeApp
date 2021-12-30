//
//  AppDelegate.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let pokemonsVM = PokemonsViewModelImpl(gateway: PokemonsGatewayImpl())
        let pokemonsVC = PokemonsViewController(viewModel: pokemonsVM)
        pokemonsVM.view = pokemonsVC
        let pokemonsNC = UINavigationController(rootViewController: pokemonsVC)
        pokemonsNC.navigationBar.prefersLargeTitles = true
        window?.rootViewController = pokemonsNC
        window?.makeKeyAndVisible()
        return true
    }
}

