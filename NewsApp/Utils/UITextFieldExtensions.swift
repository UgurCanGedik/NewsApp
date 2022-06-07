//
//  UITextFieldExtensions.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit

extension UITextField {

    func setSearchBar() {

        self.layer.borderColor =  UIColor.mainColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.placeholder = "Search"
        setLeftView()
        setRightView()
    }

    func setLeftView() {

        let searchView: UIView = {
            let tempView = UIView()
            let tempImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            tempImageView.tintColor = .mainColor
            tempImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
            tempView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            tempView.addSubview(tempImageView)
            return tempView
        }()
        self.leftView = searchView
        self.leftViewMode = .always
    }

    func setRightView() {

        self.clearButtonMode = .whileEditing
    }
}
