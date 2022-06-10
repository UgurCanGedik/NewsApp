//
//  NewsDetail.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit
import Kingfisher

class NewsDetailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsButton: UIButton!

    var viewModel: NewsDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setView()
    }

    func setStyle() {

        newsButton.createBorder(borderWidth: 2, cornerRadius: 10)
        newsImage.createBorder(cornerRadius: 10)
        setNavigationBar()
    }

    func setNavigationBar() {

        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
                                                                                              style: .plain,
                                                                                              target: nil,
                                                                                              action: nil)
        setRightButtons()
    }

    func setRightButtons() {

        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(share(_:)))
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: (viewModel?.isFavoriteNews() ?? false) ?  "heart.fill" : "heart"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(addFavorite))
        self.navigationItem.rightBarButtonItems = [favoriteButton,shareButton]
    }

    func setView() {

        guard let _viewModel = viewModel else { return }
        newsImage.kf.setImage(with: URL(string: _viewModel.getImageURL()))
        newsTitle.text = _viewModel.getTitle()
        authorLabel.text = _viewModel.getAuthor()
        dateLabel.text = _viewModel.getDate()
        descriptionLabel.text = _viewModel.getDescription()
    }

    @IBAction func newsSourceButtonPressed(_ sender: UIButton) {

        let newsSourceVC = NewsSourceVC(nibName: "NewsSourceVC", bundle: nil)
        newsSourceVC.url = viewModel?.getSourceURL()
        self.navigationController?.pushViewController(newsSourceVC, animated: true)
    }

    @objc func share(_ sender: UIButton) {

        let textToShare = "Check this news!"
        if let webSite = URL(string: viewModel?.getSourceURL() ?? "") {
            let objectsToShare = [textToShare, webSite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    @objc func addFavorite() {

        guard let _viewModel = viewModel else { return }
        if _viewModel.isFavoriteNews() {
            _viewModel.deleteArticle()
        } else {
            _viewModel.saveArticle()
        }
        setRightButtons()
    }
}
