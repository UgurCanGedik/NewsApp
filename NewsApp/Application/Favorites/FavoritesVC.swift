//
//  FavoritesVC.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoriteNewsView: UIView!
    @IBOutlet weak var noFavoriteNewsLabel: UILabel!


    var viewModel = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setScreen()
        viewModel.fetchNews()
        tableView.reloadData()
        setNoFavoriteNews()
    }

    func setNoFavoriteNews() {

        noFavoriteNewsView.isHidden = true
        noFavoriteNewsView.layer.zPosition = 2
        noFavoriteNewsView.createBorder(borderWidth: 2, cornerRadius: 50)
        noFavoriteNewsView.createShadow(shadowRadius: 10, shadowOpacity: 0.5)
        noFavoriteNewsLabel.text = "Zero\r\nFavorite News\r\nHave Found!"
        if viewModel.getArticleCount() < 1 {
            noFavoriteNewsView.isHidden = false
        }else {
            noFavoriteNewsView.isHidden = true
        }
    }

    func setScreen() {

        self.navigationController?.navigationBar.topItem?.title = "Favorites"
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {

    func setTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.identifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = .mainColor
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.getArticleCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier,
                                                 for: indexPath) as! NewsCell
        cell.setCell(title: viewModel.getTitle(index: indexPath.row),
                     description: viewModel.getDescription(index: indexPath.row),
                     image: viewModel.getImageURL(index: indexPath.row))
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return NewsCell.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detail = NewsDetailVC(nibName: "NewsDetail", bundle: nil)
        detail.viewModel = NewsDetailViewModel(article: viewModel.getModel(index: indexPath.row))
        self.navigationController?.pushViewController(detail, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            CoreData.deleteNews(url: viewModel.getModel(index: indexPath.row).url~)
            self.viewModel.fetchNews()
            self.tableView.reloadData()
            setNoFavoriteNews()
        }
    }
}
