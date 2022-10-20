//
//  TopNewsViewBuilder.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

struct TopNewsViewBuilder: ViewBuilderProtocol {
   
    func build() -> TopNewsViewController {
        let vc = TopNewsViewController()
        let newtworkManager = NetworkManager()
        let presenter = TopNewsViewPresenter(view: vc, apiClient: newtworkManager)
        
        vc.presenter = presenter
        
        return vc
    }
}
