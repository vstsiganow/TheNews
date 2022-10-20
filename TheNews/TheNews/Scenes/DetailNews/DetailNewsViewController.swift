//
//  DetailNewsViewController.swift
//  TheNews
//
//  Created by vtsyganov on 01.03.2022.
//

import UIKit

class DetailNewsViewController: BaseViewController {
    // MARK: - UI
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.contentMode = .scaleToFill
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.semanticContentAttribute = .unspecified
        
        return imageView
    }()
    
    private var newsImageHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Priperties
    var presenter: DetailNewsPresenterProtocol!
    
    // MARK: - Private Properties
    private let imageManager = ImageManager.shared
    
    private var headerAndPaddingHeight: CGFloat = 240
    private lazy var scrollHelper: ScrollViewHelper = {
        return ScrollViewHelper(scrollView: tableView, offset: -headerAndPaddingHeight)
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.setup()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.view = self
        print("viewWillAppear")
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("deinit details")
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.equalAnchorsTo(view)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.register(NewsDetailInfoTableViewCell.self, forCellReuseIdentifier: NewsDetailInfoTableViewCell.reuseIdentifier)
        tableView.register(NewsDetailContentTableViewCell.self, forCellReuseIdentifier: NewsDetailContentTableViewCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        
        var contentInset = tableView.contentInset
        contentInset.top = headerAndPaddingHeight
        tableView.contentInset = contentInset
    }
    
    private func setupImageView() {
        view.addSubview(newsImageView)
        
        newsImageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: false
        )
        
        newsImageHeightConstraint = NSLayoutConstraint(item: newsImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerAndPaddingHeight)
        
        newsImageView.addConstraint(newsImageHeightConstraint!)
        
        guard let url = presenter.getImageUrl() else { return }
        imageManager.fetchImage(url: url, imageView: newsImageView)
    }
}

extension DetailNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.getRowType(by: indexPath.row) {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailInfoTableViewCell.reuseIdentifier, for: indexPath) as! NewsDetailInfoTableViewCell
            let viewModel = presenter.getInfoCellModel()
            cell.configure(with: viewModel)
            return cell
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailContentTableViewCell.reuseIdentifier, for: indexPath) as! NewsDetailContentTableViewCell
            let viewModel = presenter.getDescriptionCellModel()
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension DetailNewsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newHeight = newsImageHeightConstraint!.constant
        
        switch scrollHelper.moveDirection {
        case .up:
            newHeight = max(0, newHeight - abs(scrollHelper.scrollDifference))
        case .down:
            if scrollView.contentOffset.y <= 0 {
                let tempHeight = min(newHeight + abs(scrollHelper.scrollDifference), view.frame.size.height/2)
                newHeight = tempHeight
            }
        }
        
        if newHeight != newsImageHeightConstraint!.constant {
            newsImageHeightConstraint!.constant = newHeight
        }
        scrollHelper.previousScrollOffset = scrollView.contentOffset.y
    }
}

extension DetailNewsViewController: DetailNewsViewControllerProtocol {
    func setupViews() {
        title = "Detail"
        setupTableView()
        setupImageView()
    }
}
