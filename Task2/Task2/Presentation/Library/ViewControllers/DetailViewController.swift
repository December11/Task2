//
//  DetailViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 17.07.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum Identifier {
        static let header = "ItemHeaderTableView"
        static let title = "ItemTitleTableViewCell"
        static let description = "ItemDescriptionTableViewCell"
    }
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    var itemURLString: String?
    var itemTitle: String?
    var itemDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ItemHeaderTableView.self, forHeaderFooterViewReuseIdentifier: Identifier.header)
        tableView.register(ItemTitleTableViewCell.self, forCellReuseIdentifier: Identifier.title)
        tableView.register(ItemDescriptionTableViewCell.self,forCellReuseIdentifier: Identifier.description)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
}

// MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    private enum Cell: Int {
        case header = 0, title, description, footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
}
