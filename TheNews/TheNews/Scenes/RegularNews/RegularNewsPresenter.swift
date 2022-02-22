//
//  RegularNewsPresenter.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

protocol RegularNewsViewPresenterProtocol: AnyObject {
    var countOfNews: Int { get }
    
    func getCellModel(by row: Int) -> RegularNewsModel
    func loadData()
}
      
class RegularNewsViewPresenter: RegularNewsViewPresenterProtocol {
    // MARK: - Properties
    weak var view: RegularNewsViewControllerProtocol?
    var countOfNews: Int {
        news.count
    }
    
    // MARK: - Private Properties
    private var news: [News] = []
    
    // MARK: - Init
    required init(view: RegularNewsViewControllerProtocol) {
        self.view = view
        //self.news = news
    }
    
    // MARK: - Protocol methods
    func getCellModel(by row: Int) -> RegularNewsModel {
        let theNews = news[row]
        
        let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssssssZ"
        
        let cell = RegularNewsModel(title: theNews.title, description: theNews.descriptions, publishedDate: theNews.publishedAt.toDate(with: dateFormat), source: theNews.source)
        
        return cell
    }
    
    func loadData() {
        news.append(News(uuid: UUID.init(), title: "These four rechargeable AAAs will replace single-use batteries for $14, more in New Green Deals", descriptions: "While the devices in our homes that use traditional batteries is dwindling with many brands moving to built-in rechargeable alternatives, it never hurts to have a few AAAs on hand for products that require them. Instead of buying single-use batteries that get…", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "dot.com", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News", descriptions: "New news", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "news.com", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News2", descriptions: "new news 2", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "com.com", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News3", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News4", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News5", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News6", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News7", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
        news.append(News(uuid: UUID.init(), title: "News8", descriptions: "new news 3", keywords: "", snippet: "", url: "", imageUrl: "", language: "", publishedAt: "2022-02-14T17:33:54.000000Z", source: "asdas.ru", categories: [], locale: ""))
    }
    
    // MARK: - Private Methods
    
}
