//
//  ViewController.swift
//  Prototype
//
//  Created by Rahul Thengadi on 06/08/21.
//

import UIKit

struct FeedImageViewModel {
    let description: String?
    let location: String?
    let imageName: String
}

class FeedViewController: UITableViewController {
    // MARK: - Properties
    
    var tableModel = [FeedImageViewModel]()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
        tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Feed"
        setupTableView()
    }
    
    private func refresh() {
        refreshControl?.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.tableModel.isEmpty {
                self.tableModel = FeedImageViewModel.prototypeData
                self.tableView.reloadData()
            }
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(FeedImageCell.self, forCellReuseIdentifier: FeedImageCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = tableModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedImageCell.identifier , for: indexPath) as! FeedImageCell
        cell.configure(with: cellModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController {
    
}

// MARK: - FFeedImageCelleed

private extension FeedImageCell {
    func configure(with model: FeedImageViewModel) {
        locationLabel.text = model.location
        locationContainer.isHidden = (model.location == nil)
        descriptionLabel.text = model.description
        descriptionLabel.isHidden = (model.description == nil)
        
        fadeIn(UIImage(named: model.imageName))
    }
}
