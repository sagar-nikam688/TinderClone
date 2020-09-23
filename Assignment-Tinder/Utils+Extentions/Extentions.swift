//
//  Extentions.swift
//  Assignment-Tinder
//
//  Created by Admin on 21/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSprigAnimation(completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: CGFloat(0.20), initialSpringVelocity: CGFloat(6.0), options: .allowUserInteraction, animations: {
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            } else {
                // Fallback on earlier versions
            }
            self.transform = .identity
        }, completion: completion)
    }
}

extension UIView {
    /// For rounding the corners of the view
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
extension UILabel {
    /// for setting cornerRadius and borderWidth
    func setBorderAndCorner(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIButton {
    func setBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}


extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
