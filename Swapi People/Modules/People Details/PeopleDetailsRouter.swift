//
//  PeopleDetailsRouter.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import UIKit

protocol PeopleDetailsRouting: AnyObject {
    
    func showDetails(fromVC: UIViewController, people: QtPeople)
}

class PeopleDetailsRouter: PeopleDetailsRouting {

    func showDetails(fromVC: UIViewController, people: QtPeople) {
        let interactor = PeopleDetailsInteractor()
        let presenter = PeopleDetailsPresenter(people: people, peopleDetailsInteractor: interactor, router: self)

        let peopleDetailsView = R.storyboard.main.peopleDetailsView()!
        peopleDetailsView.presenter = presenter

        fromVC.navigationController?.pushViewController(peopleDetailsView, animated: true)
    }

    func pop(controller: PeopleDetailsView) {
        controller.navigationController?.popViewController(animated: true)
    }
}
