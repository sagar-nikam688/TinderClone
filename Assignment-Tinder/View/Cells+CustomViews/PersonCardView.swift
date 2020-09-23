//
//  PersonCardView.swift
//  Assignment-Tinder
//
//  Created by Admin on 21/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import UIKit
import AlamofireImage

class PersonCardView: UIView {
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var personDetailsCollectionView: UICollectionView!
    @IBOutlet weak var pInfoSelectionView: UIView!
    @IBOutlet weak var pCalenderSelectionView: UIView!
    @IBOutlet weak var pLocationSelectionView: UIView!
    @IBOutlet weak var pContactSelectionView: UIView!
    @IBOutlet weak var pLockSelectionView: UIView!
    
    @IBOutlet weak var pInfoSelectionButton: UIButton!
    @IBOutlet weak var pCalenderSelectionButton: UIButton!
    @IBOutlet weak var pLocationSelectionButton: UIButton!
    @IBOutlet weak var pContactSelectionButton: UIButton!
    @IBOutlet weak var pLockSelectionButton: UIButton!

    var dataObject: PersonBO? = nil
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func setData(dataObject: PersonBO) {
        self.layer.cornerRadius = 12
        self.dataObject = dataObject
        self.personImageView.roundCorners(cornerRadius: 80)
        let size = self.personImageView.frame.size
        if let url = dataObject.picture?.large {
            self.personImageView.af_setImage(withURL: URL(string: url)!,
                                             placeholderImage: nil,
                                             filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 80.0),
                                             imageTransition: .crossDissolve(0.3))
        }
        self.personDetailsCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        self.personDetailsCollectionView.reloadData()
    }
    
    @IBAction func tabMenuChanged(_ sender: Any) {
        guard let item = (sender as AnyObject).tag else {
            return
        }
        self.personDetailsCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .left, animated: true)
        self.setSelectionViewColor(index: item)
    }
    
    func setSelectionViewColor(index: Int) {
        pInfoSelectionView.backgroundColor = .clear
        pCalenderSelectionView.backgroundColor = .clear
        pLocationSelectionView.backgroundColor = .clear
        pContactSelectionView.backgroundColor = .clear
        pLockSelectionView.backgroundColor = .clear
        
        pInfoSelectionButton.tintColor = .lightGray
        pCalenderSelectionButton.tintColor = .lightGray
        pLocationSelectionButton.tintColor = .lightGray
        pContactSelectionButton.tintColor = .lightGray
        pLockSelectionButton.tintColor = .lightGray
        switch index {
        case 0:
            pInfoSelectionView.backgroundColor = .green
            pInfoSelectionButton.tintColor = .blue
        case 1:
            pCalenderSelectionView.backgroundColor = .green
            pCalenderSelectionButton.tintColor = .blue
        case 2:
            pLocationSelectionView.backgroundColor = .green
            pLocationSelectionButton.tintColor = .blue
        case 3:
            pContactSelectionView.backgroundColor = .green
            pContactSelectionButton.tintColor = .blue
        case 4:
            pLockSelectionView.backgroundColor = .green
            pLockSelectionButton.tintColor = .blue
        default:
            break
        }

    }
}

extension PersonCardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataObject != nil ? 5 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.personDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell {
            guard let obj = self.dataObject else {
                return UICollectionViewCell()
            }
            if indexPath.row == 0 {
                cell.setUpCell(dataObject: obj, detailsType: .general)
            } else if indexPath.row == 1 {
                cell.setUpCell(dataObject: obj, detailsType: .dates)
            } else if indexPath.row == 2 {
                cell.setUpCell(dataObject: obj, detailsType: .locations)
            } else if indexPath.row == 3 {
                cell.setUpCell(dataObject: obj, detailsType: .contact)
            } else if indexPath.row == 4 {
                cell.setUpCell(dataObject: obj, detailsType: .locked)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.personDetailsCollectionView.bounds.width - 10, height: self.personDetailsCollectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in personDetailsCollectionView.visibleCells {
            let indexPath = personDetailsCollectionView.indexPath(for: cell)
            self.setSelectionViewColor(index: indexPath?.row ?? 0)
        }
    }
}
