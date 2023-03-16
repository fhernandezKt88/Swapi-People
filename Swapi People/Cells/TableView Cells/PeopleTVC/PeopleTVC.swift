//
//  PeopleTVC.swift
//  Swapi People
//
//  Created by Fidel Hernández Salazar on 3/15/23.
//

import UIKit
import PinLayout

class PeopleTVC: UITableViewCell {

    // TableView related constants
    static let nibName = String(describing: PeopleTVC.self)
    static let reuseIdentifier = nibName
    static let nib = UINib(nibName: nibName, bundle: nil)

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbMass: UILabel!
    @IBOutlet weak var lbSex: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        lbName.text = ""
        lbHeight.text = ""
        lbMass.text = ""
        lbSex.text = ""
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imgAvatar.pin.top(10).left(10)
        lbName.pin.after(of: imgAvatar, aligned: .center).right(10).marginLeft(5)
        lbMass.pin.below(of: lbName).marginTop(15).hCenter()
        lbHeight.pin.below(of: imgAvatar, aligned: .left).marginTop(15)
        lbSex.pin.below(of: lbName, aligned: .right).marginTop(15)
    }

    func configure(withPeople people: QtPeople) {
        lbName.text = people.name
        lbHeight.text = "Height: \(people.height) cm"
        lbMass.text = "Mass: \(people.mass) kg"
        lbSex.text = "Sex: \(people.gender.rawValue)"
    }
    
}
