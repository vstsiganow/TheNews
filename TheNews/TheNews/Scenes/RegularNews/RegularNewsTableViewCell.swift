//
//  RegularNewsTableViewCell.swift
//  TheNews
//
//  Created by vtsyganov on 14.02.2022.
//

import UIKit

final class RegularNewsTableViewCell: UITableViewCell {
    // - MARK: Static Properties
    static let reuseIdentifier = "RegularNewsTableViewCell"
    static let cellHeight: CGFloat = 100
    
    // - MARK: UI
    private let conteinerView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .natural
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let publishedDateLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    private let sourceLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    // - MARK: Private Properties
    private var initialLoad = true
    private let dateFormat = "MM-dd-yyyy HH:mm"
    
    
    // - MARK: Lifecycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
    func configure(at news: RegularNewsModel) {
        if initialLoad {
            setupUI()
        }
        
        initialLoad = false
        
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        publishedDateLabel.text = news.publishedDate?.toString(with: dateFormat) ?? "Unknown"
        sourceLabel.text = news.source
    }
    
    // - MARK: Private Methods
    private func setupUI() {
        addSubview(conteinerView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(sourceLabel)
        addSubview(publishedDateLabel)
        
        conteinerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
        let stackMainInfoView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackMainInfoView.distribution = .equalSpacing
        stackMainInfoView.axis = .vertical
        stackMainInfoView.spacing = 5
        conteinerView.addSubview(stackMainInfoView)
         
        let stackSecondaryInfoView = UIStackView(arrangedSubviews: [publishedDateLabel, sourceLabel])
        stackSecondaryInfoView.distribution = .equalSpacing
        stackSecondaryInfoView.axis = .horizontal
        stackSecondaryInfoView.spacing = 10
        conteinerView.addSubview(stackSecondaryInfoView)
        
        let stackFullInfoView = UIStackView(arrangedSubviews: [stackMainInfoView, stackSecondaryInfoView])
        stackFullInfoView.distribution = .fill
        stackFullInfoView.axis = .vertical
        stackFullInfoView.spacing = 5
        conteinerView.addSubview(stackFullInfoView)
        
        stackFullInfoView.anchor(top: conteinerView.topAnchor, left: conteinerView.leftAnchor, bottom: conteinerView.bottomAnchor, right: conteinerView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 0, height: 0, enableInsets: false)
    }
}
