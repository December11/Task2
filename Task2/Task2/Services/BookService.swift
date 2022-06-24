//
//  BookService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import Foundation

final class BookService {
    static let shared = BookService()
    var books = [Book]()
    
    private init() {}
    
    private func fetchBooksFromJSON() {
        let networkService = NetworkService()
        networkService.fetch { [weak self] DTOObjects in
            switch DTOObjects {
            case .failure(let error):
                print(error)
            case .success(let booksDTO):
                DispatchQueue.main.async() {
                    self?.books = booksDTO.map {
                        Book(
                            name: $0.title ?? "Untitled book",
                            authorName: $0.author ?? "No author",
                            description: $0.description ?? "No description"
                        )
                    }
                }
            }
        }
    }
}
