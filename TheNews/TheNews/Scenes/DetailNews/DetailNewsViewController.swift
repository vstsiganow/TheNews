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
    
//    private var newsImageConstraint: NSLayoutConstraint = {
//        let constraint = NSLayoutConstraint()
//
//        return constraint
//    }()
    
    // MARK: - Priperties
    var presenter: DetailNewsPresenterProtocol!
    
    // MARK: - Private Properties
    private let imageManager = ImageManager.shared
    private let headerAndPaddingHeight: CGFloat = 260
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.view = self
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        newsImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: newsImageView.image?.size.width ?? 0, height: newsImageView.image?.size.width ?? headerAndPaddingHeight, enableInsets: false)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupTableView() {
        view.addSubview(tableView)
        
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
        
        guard let url = presenter.getImageUrl() else {
            return
        }
        
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
    
}

extension DetailNewsViewController: DetailNewsViewControllerProtocol {
    func setupViews() {
        title = "Detail"
        
        setupTableView()
        setupImageView()
    }
    
}
