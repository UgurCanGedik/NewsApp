//
//  ViewController.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    var viewModel: NewsViewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        viewModel.delegate = self
        getData(isNextPage: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setVC()
    }

    func getData(isNextPage: Bool) {

        LoadingView.shared.startLoadingView(vc: self)
        viewModel.getData(isNextPage: isNextPage)
    }

    func getSearchedData(isNextPage: Bool, searhText: String) {

        LoadingView.shared.startLoadingView(vc: self)
        viewModel.getSearchedNews(isNextPage: isNextPage,
                                  searchText: searhText)
    }

    func setVC() {

        self.navigationController?.navigationBar.topItem?.title = "NewsApp"
        searchTextField.setSearchBar()
        searchTextField.delegate = self
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {

    func setTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.identifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = .mainColor
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return NewsCell.rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.setCell(title: viewModel.getTitle(index: indexPath.row),
                     description: viewModel.getDescription(index: indexPath.row),
                     image: viewModel.getImageURL(index: indexPath.row))
        cell.selectionStyle = .none
        if indexPath.row == viewModel.getArticleCount() - 1 {
            if viewModel.getSearchedStatus() && (viewModel.getArticleCount() < viewModel.getMaxSearchedArticleCount()) {
                getSearchedData(isNextPage: true,
                                searhText: searchTextField.text~)
            } else if viewModel.getArticleCount() < viewModel.getMaxArticleCount() {
                getData(isNextPage: true)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.getArticleCount()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detail = NewsDetailVC(nibName: "NewsDetail", bundle: nil)
        detail.viewModel = NewsDetailViewModel(article: viewModel.getModel(index: indexPath.row))
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension NewsVC: NewsDelegate {

    func newsDataReached() {

        tableView.reloadData()
        LoadingView.shared.stopLoadingView()
    }

    func errorReached(_ errorType: serviceErrors) {

        LoadingView.shared.stopLoadingView()
        print(errorType.description)
    }
}

extension NewsVC: UITextFieldDelegate {

    public func textFieldDidEndEditing(_ textField: UITextField) {

        if let searhText = textField.text, !searhText.isEmpty {
            let searchedText = searhText.lowercased()
            getSearchedData(isNextPage: false,
                            searhText: searchedText)
        } else {
            viewModel.searchEmpty()
            tableView.reloadData()
        }
    }
}
