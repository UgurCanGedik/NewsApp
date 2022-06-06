//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import Foundation

protocol NewsDelegate{
    func newsDataReached()
    func errorReached(_ errorType:serviceErrors)
}

class NewsViewModel {
    private var page: Int = 1
    private var searchPage: Int = 1
    private var totalNews: Int = 0
    private var searhTotalNews: Int = 0
    private var topHeadlines: [Article] = []
    private var searchedNews: [Article] = []
    private var news: [Article] = []
    var isSearhing: Bool = false
    
    var delegate: NewsDelegate?
    
    
    func getData(isNextPage: Bool) {
        if isNextPage {
            page += 1
        }

        BaseAPI.shared.request(methodType: .get,
                               apiType: .topHeadlines,
                               page: page,
                               succeed: parseData,
                               failed: failHandler)
    }
    
    func parseData(_ response: NewsModel) {
        totalNews = response.totalResults~
        news.append(contentsOf: response.articles~)
        topHeadlines = news
        delegate?.newsDataReached()
    }
    
    func getSearchedNews(isNextPage: Bool, searchText: String) {
        isSearhing = true
        if isNextPage {
            searchPage += 1
        } else {
            news = []
        }
        
        BaseAPI.shared.request(methodType: .get,
                               apiType: .searchedNews,
                               searchedText: searchText,
                               page: searchPage,
                               succeed: parseSearchedData,
                               failed: failHandler)
    }
    
    func parseSearchedData(_ response: NewsModel) {
        searhTotalNews = response.totalResults~
        searchedNews = response.articles~
        news.append(contentsOf: searchedNews)
        delegate?.newsDataReached()
    }
    
    func searchEmpty() {
        news = topHeadlines
        delegate?.newsDataReached()
        searchPage = 1
        isSearhing = false
    }
    
    func getSearchedStatus() -> Bool {
        return isSearhing
    }

    func failHandler(_ response: serviceErrors){
        delegate?.errorReached(response)
    }
    
    func getModel(index: Int)->Article{
        return news[index]
    }
    
    func getTitle(index: Int)->String{
        return news[index].title~
    }
    
    func getDescription(index: Int)->String{
        return news[index].articleDescription~
    }
    
    func getImageURL(index: Int)->String{
        return news[index].urlToImage~
    }
    
    func getArticleCount()->Int{
        return news.count
    }
    
    func getMaxArticleCount() -> Int{
        return totalNews
    }
    
    func getMaxSearchedArticleCount() -> Int {
        return searhTotalNews
    }
}
