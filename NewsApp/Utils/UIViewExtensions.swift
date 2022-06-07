//
//  UIViewExtensions.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 7.06.2022.
//

import UIKit

extension UIView {
    
    func createShadow(_ color: UIColor = .mainColor,shadowRadius: CGFloat, shadowOpacity: Float) {

        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.clipsToBounds = false
    }

    func createBorder(_ color: UIColor = .mainColor, borderWidth: CGFloat = 0, cornerRadius: CGFloat) {

        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
