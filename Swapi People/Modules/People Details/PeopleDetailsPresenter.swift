//
//  PeopleDetailsPresenter.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation

class PeopleDetailsPresenter {

    private let peopleDetailsInteractor: PeopleDetailsInteractor
    var router: PeopleDetailsRouter!
    var model: QtPeople!
    
    init(people: QtPeople, peopleDetailsInteractor: PeopleDetailsInteractor = PeopleDetailsInteractor(), router: PeopleDetailsRouter) {
        self.model = people
        self.peopleDetailsInteractor = peopleDetailsInteractor
        self.router = router
    }
}
