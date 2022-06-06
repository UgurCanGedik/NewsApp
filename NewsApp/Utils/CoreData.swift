//
//  CoreData.swift
//  NewsApp
//
//  Created by Uğur Can Gedik on 5.06.2022.
//

import UIKit
import Foundation
import CoreData

class CoreData {
    static func saveNews(article: Article) {
        let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        newItem.setValue(article.articleDescription~, forKey: "articleDescription")
        newItem.setValue(article.title~, forKey: "title")
        newItem.setValue(article.author~, forKey: "author")
        newItem.setValue(article.publishedAt~, forKey: "publishedAt")
        newItem.setValue(article.url~, forKey: "url")
        newItem.setValue(article.urlToImage~, forKey: "urlToImage")
        newItem.setValue(article.source?.name~, forKey: "source")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Saving error. \(error) - \(error.userInfo)")
        }
    }
    
    static func getNews() -> [Article] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        request.returnsObjectsAsFaults = false
        
        var news: [Article] = []
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let articleDescription = data.value(forKey: "articleDescription") as! String
                let author = data.value(forKey: "author") as! String
                let publishedAt = data.value(forKey: "publishedAt") as! String
                let url = data.value(forKey: "url") as! String
                let urlToImage = data.value(forKey: "urlToImage") as! String
                let source = data.value(forKey: "source") as! String
                let sourceModel = Source(id: nil, name: source)
                let article = Article(source: sourceModel, author: author, title: title, articleDescription: articleDescription, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: nil)
                news.append(article)
            }
        } catch {
            print("Fetching error")
        }
        
        return news
    }
    
    static func deleteNews(url: String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for data in result {
                    if let _url = data.value(forKey: "url") as? String {
                        if url == _url {
                            context.delete(data)
                        }
                    }
                    else {
                        print("unwrappingError")
                    }
                }
            }
            try context.save()
        } catch {
            print("deleting error")
        }
        print("item deleted")
    }
    
    static func isFavorite(url: String) -> Bool {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "News")
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for data in result {
                    if let _url = data.value(forKey: "url") as? String {
                        if url == _url {
                            return true
                        }
                    } else {
                        print("unwrappingError")
                    }
                }
            }
        } catch {
            print("isFavorite error")
            return false
        }
        return false
    }
}
