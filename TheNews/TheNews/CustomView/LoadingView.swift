//
//  LoadingView.swift
//  TheNews
//
//  Created by vtsyganov on 12.02.2022.
//

import UIKit

final class LoadingView: UIView {
    static let defaultHeight: CGFloat = 50
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .black
        view.layer.bounds.size = CGSize(width: defaultHeight, height: defaultHeight)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = !self.isLoading
                if self.isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    var isBlinking: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isBlinking {
                    self.blink(duration: 2, alphaMax: 0.7, alphaMin: 0.3)
                } else {
                    self.stopBlink()
                }
            }
        }
    }
    
    func add(to view: UIView) {
        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        view.equalAnchorsTo(self)

    }
}
