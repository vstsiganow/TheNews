//
//  NewsDetailContentTableViewCell.swift
//  TheNews
//
//  Created by vtsyganov on 02.03.2022.
//

import Foundation
import UIKit

struct NewsDetailContentCellModel {
    let content: String
}

class NewsDetailContentTableViewCell: UITableViewCell {
    // - MARK: Static Properties
    static let reuseIdentifier = "NewsDetailContentTableViewCell"
    
    // - MARK: UI
    private var contentLabel: UILabel = {
        let text = UILabel()
        
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 17)
        text.textAlignment = .left
        text.numberOfLines = 0
        
        return text
    }()
    
    // - MARK: Private Properties
    private var initialLoad = true
    
    // - MARK: Lifecycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        initialLoad = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: Methods
    func configure(with viewModel: NewsDetailContentCellModel) {
        if initialLoad {
            setupUI()
        }
        
        initialLoad = false
        contentLabel.text = viewModel.content
    }
    
    // - MARK: Private Methods
    private func setupUI() {
        contentView.addSubview(contentLabel)
        contentLabel.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 24,
            paddingBottom: 10,
            paddingRight: 24,
            width: 0,
            height: 0,
            enableInsets: false
        )
    }
}
