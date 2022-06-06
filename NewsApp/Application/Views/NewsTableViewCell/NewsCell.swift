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
            newsImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
            newsImageView.layer.shadowRadius = 10
            newsImageView.layer.shadowColor = UIColor(named: "AppMainColor")?.cgColor
            newsImageView.clipsToBounds = true
            newsImageView.layer.shadowOpacity = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, description: String, image: String){
        titleLabel.text = title
        descriptionLabel.text = description
        guard let url = URL(string: image) else {return}
        newsImageView.kf.setImage(with: url)
    }
    
    func setShadow() {
        
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowColor = UIColor(named: "AppMainColor")?.cgColor
        shadowView.clipsToBounds = false
        shadowView.layer.shadowOpacity = 1
    }
}
