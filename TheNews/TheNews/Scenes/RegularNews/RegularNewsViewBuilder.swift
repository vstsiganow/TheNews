//
//  RegularNewsViewBuilder.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

struct RegularNewsViewBuilder: ViewBuilderProtocol {
   
    func build() -> RegularNewsViewController {
        let vc = RegularNewsViewController()
        let newtworkManager = NetworkManager()
        let presenter = RegularNewsViewPresenter(view: vc, apiClient: newtworkManager)
        
        vc.presenter = presenter
        
        return vc
    }
}
