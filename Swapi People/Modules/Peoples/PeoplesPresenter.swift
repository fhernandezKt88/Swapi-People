//
//  PeoplesPresenter.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation

protocol PeoplesUIDelegate: AnyObject {
    
    func update(peoples: [QtPeople])
}

class PeoplesPresenter {

    weak var delegate: PeoplesUIDelegate?
    private let router: PeoplesRouter

    private let peoplesInteractor: PeoplesInteractor
    var models: [QtPeople] = []

    init(peoplesInteractor: PeoplesInteractor = PeoplesInteractor(), router: PeoplesRouter) {
        self.peoplesInteractor = peoplesInteractor
        self.router = router
    }

    func loadPeoples(page: Int, append: Bool) async {
        Task {
            let models = await self.peoplesInteractor.getPeoples(page: page)

            if append {
                self.models.append(contentsOf: models)
            } else {
                self.models = models
            }

            delegate?.update(peoples: self.models)
        }
    }

    @objc func searchQuery(query: String) {
        Task {
            self.models = await self.peoplesInteractor.searchPeoples(query: query)
            delegate?.update(peoples: models)
        }
    }

    func onTapCell(people: QtPeople) {
        router.showPeopleDetails(people: people)
    }
}
