//
//  PeoplesVC.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import UIKit
import PinLayout
import Resolver
import Refresher_Swift

/*
 * This view controller allow to search along people's
 *  and go to people details.
 */
class PeoplesVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
            self.searchBar.backgroundImage = UIImage()
            self.searchBar.placeholder = "Search for people..."
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

    @LazyInjected var swapi: Swapi
    var currentPage: Int = 1
    var peoples: [QtPeople] = [] {
        didSet {
            self.tvPeople.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadPeople(page: self.currentPage)

        // pull-bottom refresh
        self.tvPeople.bottomRefresher = Refresher {
            self.currentPage += 1
            self.loadPeople(page: self.currentPage)
        }
    }

    /// Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let pl = self.view.pin
        searchBar.pin.top(pl.safeArea).left(pl.safeArea).right(pl.safeArea)
        tvPeople.pin.below(of: searchBar).left(pl.safeArea).right(pl.safeArea).bottom(pl.safeArea)
    }

    /// Load people from given page
    func loadPeople(page: Int) {
        Task {
            do {
                let peoples = try await self.swapi.peoples(page: page)?.peoples ?? []
                self.peoples.append(contentsOf: peoples)
                self.tvPeople.bottomRefresher?.endRefreshing()
            } catch let error {
                // TODO: Show alert or something here
                print(error.localizedDescription)
                self.tvPeople.bottomRefresher?.endRefreshing()
            }
        }
    }

    /// Search for people with given query
    func searchForPeople(query: String) {
        Task {
            do {
                if query != "" {
                    self.peoples = try await self.swapi.search(query: query)?.peoples ?? []
                } else {
                    self.peoples.removeAll()
                    self.currentPage = 1
                    self.loadPeople(page: self.currentPage)
                }
            } catch let error {
                // TODO: Show alert or something here
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let typedInfo = R.segue.peoplesVC.showPeopleDetails(segue: segue) {
            let indexPath = sender as! IndexPath

            typedInfo.destination.people = self.peoples[indexPath.row]
        }
    }

}

extension PeoplesVC {

    @objc func searchForPeoples(_ searchBar: UISearchBar) {
        let query = searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""

        self.searchForPeople(query: query)
    }
}

// MARK: - Delegates

extension PeoplesVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchForPeoples(_:)), object: searchBar)
        perform(#selector(self.searchForPeoples(_:)), with: searchBar, afterDelay: 0.75)
    }

}

extension PeoplesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPeople.dequeueReusableCell(withIdentifier: PeopleTVC.reuseIdentifier, for: indexPath) as! PeopleTVC

        cell.configure(withPeople: self.peoples[indexPath.row])

        return cell
    }

}

extension PeoplesVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: R.segue.peoplesVC.showPeopleDetails, sender: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}

