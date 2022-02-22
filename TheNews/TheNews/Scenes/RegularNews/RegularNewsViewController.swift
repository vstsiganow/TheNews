//
//  RegularNewsViewController.swift
//  TheNews
//
//  Created by vtsyganov on 09.02.2022.
//

import UIKit

protocol RegularNewsViewControllerProtocol: AnyObject {
    func refreshView()
    func loadData()
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
    
    let loadingView = LoadingView()
    
    // MARK: - Properties
    var presenter: RegularNewsViewPresenterProtocol!
    
    // MARK: - Private Properties
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    // MARK: - Actions
    
    // MARK: - Methods
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate( [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
        ])
    }
    
    func updateLoadingView(with view: UIView, isLoading: Bool) {
        guard isLoading else {
            loadingView.isHidden = !isLoading
            return
        }
        
        loadingView.removeFromSuperview()
        loadingView.isLoading = isLoading
        loadingView.add(to: view)
    }
    
}


// MARK: - View Protocol
extension RegularNewsViewController: RegularNewsViewControllerProtocol {
    func loadData() {
        presenter.loadData()
    }
    
    func refreshView() {
        //presenter.refreshView()
    }
    
    
}


// MARK: - UITableView Data Source
extension RegularNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isEmpty = presenter.countOfNews == 0 ? true : false
        
        tableView.isHidden = isEmpty
        updateLoadingView(with: view, isLoading: isEmpty)
        
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
            tableView.deselectRow(at: indexPath, animated: false)
            
        }
}
