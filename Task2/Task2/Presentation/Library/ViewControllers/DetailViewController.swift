//
//  DetailViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 17.07.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum Identifier {
        static let headerCell = "ItemHeaderTableView"
        static let titleCell = "ItemTitleTableViewCell"
        static let descriptionCell = "ItemDescriptionTableViewCell"
        static let footerCell = "ItemFooterTableView"
    }
    
    private let tableView = UITableView()
    
    var itemURLString: String?
    var itemTitle: String?
    var itemDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ItemHeaderTableView.self, forHeaderFooterViewReuseIdentifier: Identifier.headerCell)
        tableView.register(ItemTitleTableViewCell.self, forCellReuseIdentifier: Identifier.titleCell)
        tableView.register(ItemDescriptionTableViewCell.self,forCellReuseIdentifier: Identifier.descriptionCell)
        tableView.register(ItemFooterTableView.self, forHeaderFooterViewReuseIdentifier: Identifier.footerCell)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
}

// MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    
    private enum Cell: Int {
        case header = 0, title, description, footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Cell.title.rawValue:
            let cell: ItemTitleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(title: itemTitle)
            
            return cell
            
        case Cell.description.rawValue:
            let cell: ItemDescriptionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(description: itemDescription)
            
            return cell
            
        default:
            
            return UITableViewCell()
        }
    }
    
}

// MARK: UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: ItemHeaderTableView = tableView.dequeueHeaderFooterView()
        guard let imageURLString = itemURLString else { return nil }
        header.configure(imageString: imageURLString)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell: ItemFooterTableView = tableView.dequeueHeaderFooterView()
        
        return cell
    }
    
}
