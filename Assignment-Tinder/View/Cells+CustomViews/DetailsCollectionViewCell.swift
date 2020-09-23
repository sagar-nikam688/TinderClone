//
//  DetailsCollectionViewCell.swift
//  Assignment-Tinder
//
//  Created by Admin on 21/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import UIKit

enum DetailsType {
    case general
    case dates
    case locations
    case contact
    case locked
}

class DetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailsContainerStackView: UIStackView!
    @IBOutlet weak var headTitleLabel: UILabel!
    @IBOutlet weak var subheadTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(dataObject: PersonBO, detailsType: DetailsType) {
        self.headTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.headTitleLabel.adjustsFontForContentSizeCategory = true
        switch detailsType {
        case .general:
            let staticText = "My name is\n"
            let title = dataObject.name?.title ?? ""
            let firstName = dataObject.name?.first ?? ""
            let last = dataObject.name?.last ?? ""
            self.headTitleLabel.text = staticText
            self.headTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subheadTitleLabel.text = title + " " + firstName + " " + last
            self.subheadTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.headTitleLabel.adjustsFontForContentSizeCategory = true
        case .dates:
            let staticText = "My date of birth is\n"
            let dob = self.convertDateFormater(dataObject.dob?.date ?? "")
            self.headTitleLabel.text = staticText + dob
        case .locations:
            let staticText = "I live in"
            self.headTitleLabel.text = staticText
            let streetNo = "\(dataObject.location?.street?.number ?? 0)"
            let streetName = dataObject.location?.street?.name ?? ""
            let city = dataObject.location?.city ?? ""
            let state = dataObject.location?.state ?? ""
            let county = dataObject.location?.country ?? ""
            self.subheadTitleLabel.text = "\(streetNo), \(streetName),\n\(city)"
            self.subTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subheadTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subTitleLabel.text = "State: \(state), Country: \(county)"
        case .contact:
            let staticText = "My contact details are"
            self.headTitleLabel.text = staticText
            let phone = dataObject.phone ?? ""
            let cell = dataObject.cell ?? ""
            self.subheadTitleLabel.text = "Phone: \(phone),"
            self.subheadTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subTitleLabel.text = "Cell: \(cell))"
        case .locked:
            let staticText = "Other details"
            self.headTitleLabel.text = staticText
            self.subheadTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            self.subheadTitleLabel.text = "Email: \(dataObject.email ?? "")"
        }
    }
    
    func convertDateFormater(_ date: String?) -> String {
        if let dob = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: dob)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)
        }
        return ""
    }
    
    override func prepareForReuse() {
        self.subheadTitleLabel.text = ""
        self.headTitleLabel.text = ""
        self.subTitleLabel.text = ""
    }
}
