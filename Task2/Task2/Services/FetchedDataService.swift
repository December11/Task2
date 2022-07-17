//
//  FetchedDataService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class FetchedDataService {
    static let shared = FetchedDataService()
    var books = [News]()
    var error: Error?
    
    private init() {
        fetch { [weak self] result in
            switch result {
            case let .failure(error):
                self?.error = error
                
            case let .success(fetchedBooks):
                self?.books = fetchedBooks
            }
        }
    }
    
    func fetch(completionBlock: @escaping (Result<[News], Error>) -> Void) {
        let networkService = NetworkService<NewsDTO>()
        networkService.fetch { DTOObjects in
            switch DTOObjects {
            case let .failure(error):
                completionBlock(.failure(error))
                
            case let .success(booksDTO):
                let fetchedBooks: [News] = booksDTO.compactMap {
                    guard
                        let imageURLString = $0.imageURLString,
                        let title = $0.title
                    else { return nil }
                    return News(
                        title: title,
                        imageURLString: imageURLString,
                        shortDescription: $0.shortDescription,
                        longDescription: $0.longDescription)
                }
                completionBlock(.success(fetchedBooks))
            }
        }
    }
    
}
