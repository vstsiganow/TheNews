//
//  ViewBuilderProtocol.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

protocol ViewBuilderProtocol {
    associatedtype ViewType: UIViewController
    
    func build() -> ViewType
    func buildWithNavigationController() -> BaseNavigationController
}

extension ViewBuilderProtocol {
    func buildWithNavigationController() -> BaseNavigationController {
        return BaseNavigationController(rootViewController: build())
    }
}
