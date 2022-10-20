//
//  NewsDetailInfoCell.swift
//  TheNews
//
//  Created by vtsyganov on 02.03.2022.
//

import Foundation
import UIKit

struct NewsDetailInfoCellModel {
    let title: String
    let date: Date
    let authors: [String]?
    let source: String?
    let description: String?
}

class NewsDetailInfoTableViewCell: UITableViewCell {
    // - MARK: Static Properties
    static let reuseIdentifier = "NewsDetailInfoTableViewCell"
    static let cellHeight: CGFloat = 100
    
    // - MARK: UI
    private let conteinerView: UIView = {
        let view = UIView()

        view.backgroundColor = .clear
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let text = UILabel()
        
        text.font = .systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        text.textAlignment = .left
        text.numberOfLines = 0
        //text.textColor = .black
        
        return text
    }()
    
    private var dateLabel: UILabel = {
        let text = UILabel()
        
        //text.textColor = .black
        text.font = .systemFont(ofSize: 12)
        text.textAlignment = .right
        text.numberOfLines = 0
        
        return text
    }()
    
    private var authorLabel: UILabel = {
        let text = UILabel()
        
        //text.textColor = .black
        text.font = .systemFont(ofSize: 12)
        text.textAlignment = .left
        text.numberOfLines = 0
        
        return text
    }()
    
    private var sourceLabel: UILabel = {
        let text = UILabel()
        
        //text.textColor = .gray
        text.font = .systemFont(ofSize: 14, weight: UIFont.Weight.heavy)
        text.textAlignment = .left
        text.numberOfLines = 0
        
        return text
    }()
    
    private let descriptionLabel: UILabel = {
        let text = UILabel()
        
        //text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 12)
        text.textAlignment = .natural
        text.numberOfLines = 0
        
        return text
    }()

    // - MARK: Private Properties
    private var initialLoad = true
    private let dateFormat = "dd-MM-yyyy HH:mm"
    
    // - MARK: Lifecycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentMode = .scaleToFill
        semanticContentAttribute = .unspecified
        selectionStyle = .none
        backgroundColor = .clear
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
    func configure(with viewModel: NewsDetailInfoCellModel) {
        if initialLoad {
            setupUI()
        }
        
        initialLoad = false
        
        titleLabel.text = viewModel.title
        sourceLabel.text = viewModel.source
        dateLabel.text = viewModel.date.toString(with: dateFormat)
        
        var authorText = "Author: Unknown"
        if let authors = viewModel.authors, !authors.isEmpty {
            authorText = authors.count > 1 ?  "Authors: \(authors.joined(separator: ", "))" : "Author: \(authors[0])"
        }
        
        authorLabel.text = authorText
        descriptionLabel.text = viewModel.description
    }
    
    // - MARK: Private Methods
    private func setupUI() {
        contentView.addSubview(conteinerView)
        
        conteinerView.addSubview(titleLabel)
        conteinerView.addSubview(sourceLabel)
        conteinerView.addSubview(authorLabel)
        conteinerView.addSubview(dateLabel)
        conteinerView.addSubview(descriptionLabel)
        
        conteinerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        let stackMainInfoView = UIStackView(arrangedSubviews: [titleLabel, sourceLabel, descriptionLabel])
        stackMainInfoView.distribution = .fill
        stackMainInfoView.axis = .vertical
        stackMainInfoView.spacing = 10
        conteinerView.addSubview(stackMainInfoView)
        
        let stackSubInfoView = UIStackView(arrangedSubviews: [authorLabel, dateLabel])
        stackSubInfoView.distribution = .fillProportionally
        stackSubInfoView.axis = .horizontal
        stackSubInfoView.spacing = 5
        conteinerView.addSubview(stackSubInfoView)

        let stackFullInfoView = UIStackView(arrangedSubviews: [stackSubInfoView, stackMainInfoView])
        stackFullInfoView.distribution = .fill
        stackFullInfoView.axis = .vertical
        stackFullInfoView.spacing = 16
        conteinerView.addSubview(stackFullInfoView)
        
        stackFullInfoView.anchor(top: conteinerView.topAnchor, left: conteinerView.leftAnchor, bottom: conteinerView.bottomAnchor, right: conteinerView.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 10, paddingRight: 24, width: 0, height: 0, enableInsets: false)
    }
}
