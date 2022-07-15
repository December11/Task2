//
//  BookService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class BookService {
    
    static let shared = BookService()
    var books = [Book]()
    var error: Error?
    
    private init() {
        fetchBooks { [weak self] result in
            switch result {
            case let .failure(error):
                self?.error = error
                
            case let .success(fetchedBooks):
                self?.books = fetchedBooks
            }
        }
    }
    
    func fetchBooks(completionBlock: @escaping (Result<[Book], Error>) -> Void) {
        let networkService = NetworkService()
        networkService.fetch { DTOObjects in
            switch DTOObjects {
            case let .failure(error):
                completionBlock(.failure(error))
                
            case let .success(booksDTO):
                let fetchedBooks: [Book] = booksDTO.compactMap {
                    guard
                        let imageURLString = $0.imageURLString,
                        let title = $0.title,
                        let description = $0.shortDescription
                    else { return nil }
                    return Book(imageURLString: imageURLString, name: title, description: description)
                }
                completionBlock(.success(fetchedBooks))
            }
        }
    }
    
}
