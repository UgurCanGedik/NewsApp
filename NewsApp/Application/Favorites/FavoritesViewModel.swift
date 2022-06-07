//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation

class FavoritesViewModel {
    
    var news: [Article]

    init() {

        self.news = CoreData.getNews()
    }

    func fetchNews() {

        news = CoreData.getNews()
    }

    func getModel(index: Int) -> Article {

        return news[index]
    }

    func getTitle(index: Int) -> String {

        return news[index].title~
    }

    func getDescription(index: Int) -> String {

        return news[index].articleDescription~
    }

    func getImageURL(index: Int) -> String {

        return news[index].urlToImage~
    }

    func getArticleCount() -> Int {

        return news.count
    }
}
