//
//  RegularNewsPresenter.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import Foundation

protocol RegularNewsViewPresenterProtocol: AnyObject {
    
    var view: RegularNewsViewControllerProtocol? { get set }
    var countOfNews: Int { get }
    
    func setup()
    func viewWillApear()
    func didDropDownList()
    func getCellModel(by row: Int) -> RegularNewsModel
    func didSelect(at row: Int)
}

class RegularNewsViewPresenter: RegularNewsViewPresenterProtocol {
    
    // MARK: - Properties
    weak var view: RegularNewsViewControllerProtocol?
    var countOfNews: Int {
        news.count
    }
    
    // MARK: - Private Properties
    private var news: [News] = []
    private var network: ApiClient
    
    // MARK: - Init
    required init(view: RegularNewsViewControllerProtocol, apiClient: ApiClient) {
        self.view = view
        self.network = apiClient
    }
    
    // MARK: - Protocol methods
    func setup() {
        view?.setupViews()
    }
    
    func viewWillApear() {
        loadData()
    }
    
    func getCellModel(by row: Int) -> RegularNewsModel {
        let theNews = news[row]
        
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let cell = RegularNewsModel(title: theNews.title, publishedDate: theNews.publishedAt.toDate(with: dateFormat), author: theNews.creator, imageURL: theNews.imageURL)
        
        return cell
    }
    
    func didDropDownList() {
        loadData()
    }
    
    func didSelect(at row: Int) {
        let news = news[row]
        pushDetailView(with: news)
    }
    
    // MARK: - Private Methods
    private func loadData() {
        if news.isEmpty { view?.showLoadingUI() }
        
        let serialQueue = DispatchQueue(label: "com.vstsiganov", qos: .utility)
        
        network.getNews(completion: { result in
            serialQueue.async {
                switch result {
                case .success(let news):
                    print("success")
                    self.news = news
                    self.view?.refreshList()
                case .failure:
                    print("failure")
                    self.news = []
                }
            }
        })
    }
    
    private func pushDetailView(with news: News) {
        let detailVC = DetailNewsViewBuilder(news: news).build()
        view?.pushDetailView(detailVC)
    }
}
