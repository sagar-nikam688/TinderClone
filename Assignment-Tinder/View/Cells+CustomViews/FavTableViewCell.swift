//
//  FavTableViewCell.swift
//  Assignment-Tinder
//
//  Created by Admin on 22/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var contactlabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowRadius = 2
            containerView.layer.cornerRadius = 14
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
            containerView.layer.masksToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.addGradientBackground(firstColor: UIColor(named: "themeColor") ?? .blue, secondColor: UIColor.cyan.withAlphaComponent(0.8))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(dataObject: PersonBO) {
        let title = dataObject.name?.title ?? ""
        let firstName = dataObject.name?.first ?? ""
        let last = dataObject.name?.last ?? ""
        let fullName = "\(title) \(firstName) \(last)"
        self.nameLabel.text = fullName
        self.ageLabel.text = "Age: \(dataObject.dob?.age ?? 0)"
        self.cityTitleLabel.text = "City: \(dataObject.location?.city ?? "NA")"
        self.contactlabel.text = "Contact: \(dataObject.cell ?? "NA")"
    }
    
}
