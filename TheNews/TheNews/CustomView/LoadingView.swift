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
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: defaultHeight),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
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
    
    func add(to view: UIView) {
        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
}
