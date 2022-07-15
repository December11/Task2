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
            components.path = "/v0/b/table-ec07d.appspot.com/o/books.json"
            components.queryItems = [
                URLQueryItem(name: "alt", value: "media"),
                URLQueryItem(name: "token", value: "041cdf86-c3a2-4ddf-84a0-734b63a70941")
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
                completionBlock(.success(json.items))
            } catch {
                completionBlock(.failure(error))
            }
        }
        task.resume()
    }
    
}
