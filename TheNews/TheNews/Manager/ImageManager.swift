//
//  ImageManager.swift
//  TheNews
//
//  Created by vtsyganov on 07.03.2022.
//

import UIKit

class ImageManager {
    // MARK: - Static Properties
    static let shared = ImageManager()
    
    // MARK: - Properties
    
    
    // MARK: - Private Properties
    
    
    // MARK: - Lifecycle Methods
    private init() {}
    
    // MARK: - Methods
    func fetchImage(url: URL, imageView: UIImageView) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                imageView.image = UIImage(systemName: "newspaper")
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
                imageView.backgroundColor = .none
            }
        }
    }
    
    // MARK: - Private Methods
    
    
}
