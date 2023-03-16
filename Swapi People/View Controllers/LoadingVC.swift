//
//  LoadingVC.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import UIKit

class LoadingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let windows = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first

        let nc = R.storyboard.main.mainNC()
        windows!.rootViewController = nc
        windows!.makeKeyAndVisible()
    }

}
