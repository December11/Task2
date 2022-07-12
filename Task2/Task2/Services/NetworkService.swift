//
//  NetworkService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import Foundation

final class NetworkService {
    
    func fetch(completionBlock: @escaping (Result<[BookDTO], Error>) -> Void) {
        
        let session = URLSession.shared
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "firebasestorage.googleapis.com"
            components.path = "/v0/b/books-6bcec.appspot.com/o/books.json"
            components.queryItems = [
                URLQueryItem(name: "alt", value: "media"),
                URLQueryItem(name: "token", value: "44a536f2-11ea-42fb-a84b-b665e4e05fff")
            ]
            
            return components
        }
        
        guard let url = urlComponents.url else { return }
        let task = session.dataTask(with: url) { data, _, error in
            guard
                error == nil,
                let data = data
            else {
                if let error = error {
                    completionBlock(.failure(error))
                }
                return
            }
            do {
                let json = try JSONDecoder().decode(BookListDTO.self, from: data)
                completionBlock(.success(json.books))
            } catch {
                completionBlock(.failure(error))
            }
        }
        task.resume()
    }
    
}
