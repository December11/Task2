//
//  FetchedDataService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class FetchedDataService {
    
    enum Service {
        
        case books
        case news
        
        static var booksNetworkService: NetworkService<BookDTO> {
            let service = NetworkService<BookDTO>()
            service.path = "/v0/b/table-ec07d.appspot.com/o/books.json"
            service.queryItems = [
                URLQueryItem(name: "alt", value: "media"),
                URLQueryItem(name: "token", value: "041cdf86-c3a2-4ddf-84a0-734b63a70941")
            ]
            
            return service
        }
        
        static var newsNetworkService: NetworkService<NewsDTO> {
            let service = NetworkService<NewsDTO>()
            service.path = "/v0/b/table-ec07d.appspot.com/o/news.json"
            service.queryItems = [
                URLQueryItem(name: "alt", value: "media"),
                URLQueryItem(name: "token", value: "ff9c6435-86cb-4d11-ae49-1e56d7eb6b89")
            ]
            
            return service
        }
        
        static func randomCase() -> FetchedDataService.Service {
            let array = [FetchedDataService.Service.books, FetchedDataService.Service.news]
            return array[Int.random(in: 0...1)]
        }
    }

    var items = [Fetchable]()
    var error: Error?
    let service: Service
    
    init(service: Service) {
        self.service = service
        
        fetch { [weak self] result in
            switch result {
            case let .failure(error):
                self?.error = error
                
            case let .success(fetchedItems):
                self?.items = fetchedItems
            }
        }
    }
    
    func fetch(completionBlock: @escaping (Result<[Fetchable], Error>) -> Void) {
        switch service {
        case .books:
            let networkService = Service.booksNetworkService
            networkService.fetch { result in
                switch result {
                case let .failure(error):
                    completionBlock(.failure(error))
                    
                case let .success(items):
                    let items: [Book] = items.compactMap {
                        guard
                            let imageURLString = $0.imageURLString,
                            let title = $0.title
                        else { return nil }
                        return Book(
                            title: title,
                            imageURLString: imageURLString,
                            shortDescription: $0.shortDescription,
                            longDescription: $0.longDescription)
                    }
                    completionBlock(.success(items))
                }
            }
            
        case .news:
            let networkService = Service.newsNetworkService
            networkService.fetch { result in
                switch result {
                case let .failure(error):
                    completionBlock(.failure(error))
                    
                case let .success(items):
                    let items: [News] = items.compactMap {
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
                    completionBlock(.success(items))
                }
            }
        }
    }

}
