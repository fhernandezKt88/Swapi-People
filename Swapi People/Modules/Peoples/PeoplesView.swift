//
//  PeoplesView.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import Foundation
import UIKit
import Async
import PinLayout
import Refresher_Swift

class PeoplesView: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
            self.searchBar.backgroundImage = UIImage()
            self.searchBar.placeholder = "Search for peoples..."
        }
    }
    
    @IBOutlet weak var tvPeople: UITableView! {
        didSet {
            self.tvPeople.delegate = self
            self.tvPeople.dataSource = self
            self.tvPeople.register(PeopleTVC.nib, forCellReuseIdentifier: PeopleTVC.reuseIdentifier)
            self.tvPeople.backgroundColor = .clear
        }
    }
    
    var presenter: PeoplesPresenter!
    var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await presenter?.loadPeoples(page: self.currentPage, append: false)
        }

        // pull-bottom refresh
        self.tvPeople.bottomRefresher = Refresher {
            self.currentPage += 1

            Task {
                await self.presenter.loadPeoples(page: self.currentPage, append: true)
            }
        }
    }

    /// Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let pl = self.view.pin
        searchBar.pin.top(pl.safeArea).left(pl.safeArea).right(pl.safeArea)
        tvPeople.pin.below(of: searchBar).left(pl.safeArea).right(pl.safeArea).bottom(pl.safeArea)
    }

    @objc func searchForPeoples(_ searchBar: UISearchBar) {
        let query = searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""

        self.presenter.searchQuery(query: query)
    }
}

extension PeoplesView: PeoplesUIDelegate {

    func update(peoples: [QtPeople]) {

        Async.main {
            self.tvPeople.reloadData()
            self.tvPeople.bottomRefresher?.endRefreshing()
        }
    }
}

extension PeoplesView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchForPeoples(_:)), object: searchBar)
        perform(#selector(self.searchForPeoples(_:)), with: searchBar, afterDelay: 0.75)
    }
}

extension PeoplesView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter!.models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPeople.dequeueReusableCell(withIdentifier: PeopleTVC.reuseIdentifier, for: indexPath) as! PeopleTVC

        cell.configure(withPeople: self.presenter!.models[indexPath.row])
        return cell
    }
}

extension PeoplesView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.onTapCell(people: self.presenter!.models[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
