//
//  PeoplesRouter.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import UIKit

class PeoplesRouter {

    var peoplesView: PeoplesView!
    var peopleDetailsRouter: PeopleDetailsRouter?

    /// Show list of peoples - main view controller
    func showListOfPeoples(window: UIWindow?) {
        self.peoplesView = R.storyboard.main.peoplesView()!
        let presenter = PeoplesPresenter(router: self)
        presenter.delegate = self.peoplesView
        self.peoplesView?.presenter = presenter

        self.peopleDetailsRouter = PeopleDetailsRouter()

        let nc = UINavigationController(rootViewController: self.peoplesView)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }

    func showPeopleDetails(people: QtPeople) {
        guard let vc = self.peoplesView else { return }
        self.peopleDetailsRouter?.showDetails(fromVC: vc, people: people)
    }
}
