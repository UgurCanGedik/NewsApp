//
//  NewsCell.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    static let identifier: String = "NewsCellIdentifier"
    static let rowHeight: CGFloat = 120
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var newsImageView: UIImageView! {
        didSet {
            newsImageView.layer.masksToBounds = true
            newsImageView.layer.cornerRadius = 10
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(title: String, description: String, image: String) {

        titleLabel.text = title
        descriptionLabel.text = description
        guard let url = URL(string: image) else {return}
        newsImageView.kf.setImage(with: url)
    }

    func setShadow() {

        shadowView.createBorder(cornerRadius: 10)
        shadowView.createShadow(shadowRadius: 5, shadowOpacity: 1)
    }
}
