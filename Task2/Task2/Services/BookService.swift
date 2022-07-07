//
//  BookService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

final class BookService {
    static let shared = BookService()
    
    private init() {}
    
    func fetchBooks(completionBlock: @escaping ([Book]) -> Void) {
        let networkService = NetworkService()
        networkService.fetch { DTOObjects in
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
                completionBlock(fetchedBooks)
            }
        }
    }
}
