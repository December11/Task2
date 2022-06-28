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
    
    func getBooks(completionBlock: @escaping ([Book]) -> Void) {
        fetchBooksFromJSON { [weak self] fetchedBooks in
            self?.books = fetchedBooks
            print("1. books count = ", self?.books.count)
            completionBlock(fetchedBooks)
        }
    }
    
    private func fetchBooksFromJSON(completionBlock: @escaping ([Book]) -> Void) {
        let networkService = NetworkService()
        networkService.fetch { [weak self] DTOObjects in
            switch DTOObjects {
            case .failure(let error):
                print(error)
                completionBlock([])
            case .success(let booksDTO):
                let fetchedBooks = booksDTO.map {
                    Book(
                        name: $0.title ?? "Untitled book",
                        authorName: $0.author ?? "No author",
                        description: $0.description ?? "No description"
                    )
                }
                
                print("0. I parced \(String(describing: self?.books.count)) books")
                completionBlock(fetchedBooks)
            }
        }
    }
}
