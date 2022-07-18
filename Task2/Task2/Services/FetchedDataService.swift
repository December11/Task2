//
//  FetchedDataService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

final class FetchedDataService<ItemsType: Fetchable, TypeDTO: Decodable> {
    
    enum Service {
        
        case books
        case news
        
        var networkService: NetworkService<TypeDTO> {
            switch self {
            case .books:
                let service = NetworkService<TypeDTO>()
                service.path = "/v0/b/table-ec07d.appspot.com/o/books.json"
                service.queryItems = [
                    URLQueryItem(name: "alt", value: "media"),
                    URLQueryItem(name: "token", value: "041cdf86-c3a2-4ddf-84a0-734b63a70941")
                ]
                
                return service
                
            case .news:
                let service = NetworkService<TypeDTO>()
                service.path = "/v0/b/table-ec07d.appspot.com/o/news.json"
                service.queryItems = [
                    URLQueryItem(name: "alt", value: "media"),
                    URLQueryItem(name: "token", value: "ff9c6435-86cb-4d11-ae49-1e56d7eb6b89")
                ]
                
                return service
                
            }
        }
    }

    var items = [ItemsType]()
    var error: Error?
    
    init(service: Service) {
        fetch(networkService: service) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.error = error
                
            case let .success(fetchedItems):
                self?.items = fetchedItems
            }
        }
    }
    
    func fetch(service: Service, completionBlock: @escaping (Result<[ItemsType], Error>) -> Void) {
        
        networkService.fetch { DTOObjects in
            switch DTOObjects {
            case let .failure(error):
                completionBlock(.failure(error))
                
            case let .success(itemsDTO):
                let result = itemsDTO.compactMap {
                    guard
                        let imageURLString = $0.imageURLString,
                        let title = $0.title
                    else { return nil }
                    return ItemsType(
                        title: title,
                        imageURLString: imageURLString,
                        shortDescription: $0.shortDescription,
                        longDescription: $0.longDescription)
                }
                completionBlock(.success(result))
            }
        }
    }
    
}
