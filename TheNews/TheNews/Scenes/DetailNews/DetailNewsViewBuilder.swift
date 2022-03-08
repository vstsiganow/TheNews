//
//  DetailNewsViewBuilder.swift
//  TheNews
//
//  Created by vtsyganov on 01.03.2022.
//

import UIKit

struct DetailNewsViewBuilder: ViewBuilderProtocol {
   
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
    func build() -> DetailNewsViewController {
        let vc = DetailNewsViewController()
        let presenter = DetailNewsPresenter(news: news)
        
        vc.presenter = presenter
        
        return vc
    }
}
