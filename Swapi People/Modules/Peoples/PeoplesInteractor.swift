//
//  PeoplesInteractor.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import Resolver

class PeoplesInteractor {

    @LazyInjected var swapi: Swapi

    func getPeoples(page: Int) async -> [QtPeople] {
        do {
            return try await self.swapi.peoples(page: page)?.peoples ?? []
        } catch {
            return []
        }
    }

    func searchPeoples(query: String) async -> [QtPeople] {
        do {
            return try await self.swapi.search(query: query) ?? []
        } catch {
            return []
        }
    }
}
