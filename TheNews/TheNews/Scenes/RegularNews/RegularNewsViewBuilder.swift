//
//  RegularNewsViewBuilder.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

class RegularNewsViewBuilder: ViewBuilderProtocol {
   
    func build() -> RegularNewsViewController {
        let vc = RegularNewsViewController()
        let presenter = RegularNewsViewPresenter(view: vc)
        vc.presenter = presenter
        
        return vc
    }
}
