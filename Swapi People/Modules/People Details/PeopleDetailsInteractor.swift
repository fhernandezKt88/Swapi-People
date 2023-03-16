//
//  PeopleDetailsInteractor.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import Resolver

class PeopleDetailsInteractor {

    @LazyInjected var swapi: Swapi

    func getPeople(id: Int) async -> QtPeople? {
        do {
            return try await self.swapi.people(id: id)
        } catch {
            return nil
        }
    }
}
