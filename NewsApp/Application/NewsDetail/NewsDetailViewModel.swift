//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation

class NewsDetailViewModel {

    private var article: Article
    private var isFavorite: Bool

    init(article: Article) {

        self.article = article
        self.isFavorite = CoreData.isFavorite(url: article.url~)
    }

    func getTitle() -> String {

        return article.title~
    }

    func getDescription() -> String {

        return article.articleDescription~
    }

    func getImageURL() -> String {

        return article.urlToImage~
    }

    func getDate() -> String {

        return article.publishedAt~.getDate()
    }

    func getAuthor() -> String {

        return article.source?.name ?? ""
    }

    func getSourceURL() -> String {

        return article.url~
    }

    func isFavoriteNews() -> Bool {

        return self.isFavorite
    }

    func saveArticle() {

        CoreData.saveNews(article: article)
        isFavorite = CoreData.isFavorite(url: article.url~)
    }

    func deleteArticle() {

        CoreData.deleteNews(url: article.url~)
        isFavorite = CoreData.isFavorite(url: article.url~)
    }
}
