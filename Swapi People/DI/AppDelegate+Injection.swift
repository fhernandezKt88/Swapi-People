//
//  AppDelegate+Injection.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    // Register all my services here
    public static func registerAllServices() {
        Resolver.register { Swapi() }
    }
}
