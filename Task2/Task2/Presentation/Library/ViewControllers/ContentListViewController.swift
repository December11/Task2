//
//  ViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import SnapKit
import UIKit

final class ContentListViewController: UIViewController {
    
    private enum Constants {
        static let cellIdentifier = "ContentListTableViewCell"
        static let cellHeight = 108.0
    }
    
    private let tableView = UITableView()
    
    var content = [FetchedDataProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
    }
    
    private func configureUI() {
        tableView.register(ContentListTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: UITableViewDataSource

extension ContentListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContentListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        guard content.indices.contains(indexPath.row) else { return UITableViewCell() }
        let currentItem = content[indexPath.row]
        cell.configure(item: currentItem) { [weak self] in
            self?.showAlert(title: "\(indexPath.row + 1)th book")
        }
        if indexPath.row == 0 {
            cell.separatorView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    private func showAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        present(alertController, animated: true)
    }
    
}

// MARK: UITableViewDelegate

extension ContentListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let details = DetailViewController()
        let currentItem = content[indexPath.row]
        details.itemURLString = currentItem.imageURLString
        details.itemTitle = currentItem.title
        details.itemDescription = currentItem.longDescription ?? currentItem.shortDescription
        present(details, animated: true)
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            content.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
