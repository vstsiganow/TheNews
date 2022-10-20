//
//  TopNewsViewController.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

protocol TopNewsViewControllerProtocol: AnyObject {
    func setupViews()
    func refreshList()
    func showLoadingUI()
    func pushDetailView(_ pushedView: BaseViewController)
}

class TopNewsViewController: BaseViewController {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let loadingView = LoadingView()
    
    // MARK: - Properties
    var presenter: TopNewsViewPresenterProtocol!
    
    // MARK: - Private Properties
    private enum State {
        case initial, loading, showList
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial: break
            case .loading: updateLoadingView(true, blinking: true)
            case .showList: updateData()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        refreshControl.tintColor = .black
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
        
        tableView.equalAnchorsTo(view)
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.updateLoadingView(false, blinking: false)
            self.tableView.reloadData()
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func updateLoadingView(_ isLoading: Bool, blinking: Bool) {
        guard isLoading else {
            tableView.isHidden = false
            loadingView.isHidden = true
            return
        }
        
        tableView.isHidden = true
        loadingView.isHidden = false
        
        loadingView.removeFromSuperview()
        loadingView.isLoading = isLoading
        loadingView.isBlinking = blinking
        loadingView.add(to: view)
    }
}

// MARK: - View Protocol
extension TopNewsViewController: TopNewsViewControllerProtocol {
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
extension TopNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.reuseIdentifier, for: indexPath) as! TopNewsTableViewCell
        let selectedNews = presenter.getCellModel(by: indexPath.row)
        
        cell.configure(at: selectedNews)
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension TopNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelect(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopNewsTableViewCell.cellHeight
    }
}
