//
//  DetailNewsPresenter.swift
//  TheNews
//
//  Created by vtsyganov on 01.03.2022.
//

import Foundation

protocol DetailNewsViewControllerProtocol: AnyObject {
    func setupViews()
}

enum NewsDetailRowType: Int {
    case info, content
}

protocol DetailNewsPresenterProtocol {
    var view: DetailNewsViewControllerProtocol? { get set }
    var rows: Int { get }
    
    func setup()
    func getRowType(by row: Int) -> NewsDetailRowType
    func getInfoCellModel() -> NewsDetailInfoCellModel
    func getDescriptionCellModel() -> NewsDetailContentCellModel
    func getImageUrl() -> URL?
}

class DetailNewsPresenter: DetailNewsPresenterProtocol {
    // MARK: - DetailNewsPresenterProtocol Properties
    weak var view: DetailNewsViewControllerProtocol?
    var rows: Int { 2 }
    
    // MARK: - Private Properties
    private let news: News
    
    private let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    // MARK: - Lifecycle Methods
    init(news: News) {
        self.news = news
    }
    
    // MARK: - DetailNewsPresenterProtocol Methods
    func setup() {
        view?.setupViews()
    }
    
    func getRowType(by row: Int) -> NewsDetailRowType {
        guard let type = NewsDetailRowType(rawValue: row) else {
            fatalError("Wrong row")
        }
        return type
    }
    
    func getInfoCellModel() -> NewsDetailInfoCellModel {
        NewsDetailInfoCellModel(title: news.title, date: news.publishedAt.toDate(with: dateFormat), author: news.author, source: news.source.name)
    }
    
    func getDescriptionCellModel() -> NewsDetailContentCellModel {
        NewsDetailContentCellModel(content: news.content)
    }
    
    func getImageUrl() -> URL? {
        return URL(string: news.imageUrl)
    }
}
