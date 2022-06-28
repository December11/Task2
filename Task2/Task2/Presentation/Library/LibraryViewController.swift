//
//  ViewController.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private var books = BookService.shared.books
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        BookService.shared.getBooks { [weak self] fetchedBooks in
            self?.books = fetchedBooks
            print("2.VC. books.count = \(self?.books.count)")
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LibraryCell.self, forCellReuseIdentifier: "libraryCell")
        configurateUI()
    }
    
    
    private func configurateUI() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
    }
}

// MARK: UITableViewDataSource

extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as? LibraryCell
        else { return UITableViewCell() }
        
        let currentBook = books[indexPath.row]
        cell.configurateCell(name: currentBook.name, description: currentBook.description)
        return cell
    }
    
    
}

// MARK: UITableViewDelegate

extension LibraryViewController: UITableViewDelegate {
    
}

