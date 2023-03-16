//
//  PeopleDetailsVC.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import UIKit
import PinLayout
import Atributika

/*
 * This view controller show people details.
 */
class PeopleDetailsVC: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMass: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbHairColor: UILabel!
    @IBOutlet weak var lbBirthYear: UILabel!
    @IBOutlet weak var lbEyeColor: UILabel!

    var people: QtPeople!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }

    func configureUI() {
        let small = Style("sm").font(.boldSystemFont(ofSize: 10)).foregroundColor(.lightGray)

        self.lbName.text = people.name
        self.lbMass.attributedText = "<sm>Mass:</sm> \(people.mass) <sm>kg</sm>".style(tags: small).attributedString
        self.lbHeight.attributedText = "<sm>Height:</sm> \(people.height) <sm>cm</sm>".style(tags: small).attributedString
        self.lbGender.attributedText = "<sm>Gender:</sm> \(people.gender.rawValue)".style(tags: small).attributedString
        self.lbHairColor.attributedText = "<sm>Hair color:</sm> \(people.hairColor)".style(tags: small).attributedString
        self.lbBirthYear.attributedText = "<sm>Birth year:</sm> \(people.birthYear)".style(tags: small).attributedString
        self.lbEyeColor.attributedText = "<sm>Eye color:</sm> \(people.eyeColor)".style(tags: small).attributedString
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let pl = self.view.pin

        lbName.pin.top(pl.safeArea).left(pl.safeArea).right(pl.safeArea).margin(20, 20, 0)

        /// Left
        lbMass.pin.below(of: lbName, aligned: .left).marginTop(30)
        lbGender.pin.below(of: lbMass, aligned: .left).marginTop(10)
        lbBirthYear.pin.below(of: lbGender, aligned: .left).marginTop(10)

        /// Right
        lbHeight.pin.below(of: lbName, aligned: .right).marginTop(30)
        lbHairColor.pin.below(of: lbHeight, aligned: .right).marginTop(10)
        lbEyeColor.pin.below(of: lbHairColor, aligned: .right).marginTop(10)
    }
    
    @IBAction func actBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
