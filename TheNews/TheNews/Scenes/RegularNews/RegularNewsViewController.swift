//
//  RegularNewsViewController.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

protocol RegularNewsViewControllerProtocol: AnyObject {
    func setupViews()
    func refreshList()
    func showLoadingUI()
    func pushDetailView(_ pushedView: BaseViewController)
}

class RegularNewsViewController: BaseViewController {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(RegularNewsTableViewCell.self, forCellReuseIdentifier: RegularNewsTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let loadingView = LoadingView()
    
    // MARK: - Properties
    var presenter: RegularNewsViewPresenterProtocol!
    
    // MARK: - Private Properties
    private enum State {
        case initial, loading, showList
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial: break
            case .loading: updateLoadingView(true)
            case .showList: updateData()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.view = self
        presenter.viewWillApear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.view = nil
    }
    
    // MARK: - Actions
    @objc private func refreshControlDidPull() {
        presenter.didDropDownList()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(tableView)
        tableView.refreshControl = refreshControl
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private func updateData() {
        updateLoadingView(false)
        tableView.reloadData()
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    private func updateLoadingView(_ isLoading: Bool) {
        guard isLoading else {
            tableView.isHidden = false
            loadingView.isHidden = true
            return
        }
        
        tableView.isHidden = true
        loadingView.isHidden = false
        
        loadingView.removeFromSuperview()
        loadingView.isLoading = isLoading
        loadingView.add(to: view)
    }
}

// MARK: - View Protocol
extension RegularNewsViewController: RegularNewsViewControllerProtocol {
    func setupViews() {
        setupUI()
    }
    
    func refreshList() {
        state = .showList
    }
    
    func showLoadingUI() {
        state = .loading
    }
    
    func pushDetailView(_ pushedView: BaseViewController) {
        navigationController?.pushViewController(pushedView, animated: true)
    }
}

// MARK: - UITableView Data Source
extension RegularNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegularNewsTableViewCell.reuseIdentifier, for: indexPath) as! RegularNewsTableViewCell
        let selectedNews = presenter.getCellModel(by: indexPath.row)
        
        cell.configure(at: selectedNews)
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension RegularNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelect(at: indexPath.row)
    }
}
