//
//  NetworkService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import Foundation

final class NetworkService<TypeDTO: Decodable> {
    
    let session = URLSession.shared
    let scheme = "https"
    let host = "firebasestorage.googleapis.com"
    var path = "/v0/b/table-ec07d.appspot.com/o/news.json"
    var queryItems = [URLQueryItem]()
    
    func fetch(completionBlock: @escaping (Result<[TypeDTO], Error>) -> Void) {
        var urlComponents: URLComponents {
            var components = URLComponents()
//            components.scheme = "https"
//            components.host = "firebasestorage.googleapis.com"
//            components.path = "/v0/b/table-ec07d.appspot.com/o/books.json"
//            components.queryItems = [
//                URLQueryItem(name: "alt", value: "media"),
//                URLQueryItem(name: "token", value: "041cdf86-c3a2-4ddf-84a0-734b63a70941")
//            ]
            
            components.scheme = scheme
            components.host = host
            components.path = path
            components.queryItems = queryItems
            
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
                let json = try JSONDecoder().decode(ItemsDTO<TypeDTO>.self, from: data)
                completionBlock(.success(json.items))
            } catch {
                completionBlock(.failure(error))
            }
        }
        task.resume()
    }
    
}
