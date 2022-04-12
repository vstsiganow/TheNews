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
    static let cellHeight: CGFloat = 120
    static let imageSize: CGFloat = 70
    
    // - MARK: UI
    private let conteinerView: UIView = {
        let view = UIView(frame: .zero)
        
        view.layer.masksToBounds = true
        view.backgroundColor = ThemeColor.showWhite.color
        
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
    
    private let publishedTimeLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    private var newsImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: RegularNewsTableViewCell.imageSize, height: RegularNewsTableViewCell.imageSize))
    
    private var infoStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    // - MARK: Private Properties
    private var initialLoad = true
    private let imageManager = ImageManager.shared
    private let dateFormat = "MM-dd-yyyy HH:mm"
    
    // - MARK: Lifecycle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        initialLoad = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: Methods
    func configure(at news: RegularNewsModel) {
        titleLabel.text = news.title
        publishedTimeLabel.text = calculatePublishedTimeInterval(news.publishedDate)
        
        if initialLoad {
            DispatchQueue.main.async {
            
                self.setupViews()
                self.setupLayout()
            }
            
            if let stringURL = news.imageURL, let url = URL(string: stringURL) {
                imageManager.fetchImage(url: url, imageView: newsImageView)
            } else {
                newsImageView.image = UIImage(systemName: "photo")
            }
        }
        
        initialLoad = false
    }
    
    // - MARK: Private Methods
    private func setupViews() {
        newsImageView.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            self.newsImageView.roundedView(to: 10)
            self.conteinerView.roundedView(to: 10, with: .bottomLeft)
        }
    }
    
    private func setupLayout() {
        addSubview(conteinerView)
        addSubview(titleLabel)
        addSubview(publishedTimeLabel)
        addSubview(newsImageView)
        addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(publishedTimeLabel)
        
        conteinerView.addSubview(infoStackView)
        
        conteinerView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 20,
            paddingLeft: 30,
            paddingBottom: 10,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false
        )
        
        newsImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: nil,
            right: nil,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 0,
            width: RegularNewsTableViewCell.imageSize,
            height: RegularNewsTableViewCell.imageSize,
            enableInsets: false
        )
        
        infoStackView.anchor(
            top: conteinerView.topAnchor,
            left: conteinerView.leftAnchor,
            bottom: conteinerView.bottomAnchor,
            right: conteinerView.rightAnchor,
            paddingTop: 5,
            paddingLeft: 70,
            paddingBottom: 10,
            paddingRight: 10,
            width: 0,
            height: 0,
            enableInsets: false
        )
    }
    
    private func calculatePublishedTimeInterval(_ date: Date?) -> String {
        guard let dateComponent = date?.time(to: Date()) else { return "Recently" }
        
        if let years = dateComponent.year, years > 0 {
            return "\(years) years ago"
        } else if let months = dateComponent.month, months > 0 {
            return "\(months) months ago"
        } else if let days = dateComponent.day, days > 0 {
            return "\(days) days ago"
        } else if let hours = dateComponent.hour, hours > 0 {
            return "\(hours) hours ago"
        } else if let minutes = dateComponent.minute, minutes > 0 {
            return "\(minutes) minutes ago"
        } else {
            return "Recently"
        }
    }
}
