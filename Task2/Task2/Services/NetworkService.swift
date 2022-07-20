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
    var path = ""
    var queryItems = [URLQueryItem]()
    
    func fetch(completionBlock: @escaping (Result<[TypeDTO], Error>) -> Void) {
        var urlComponents: URLComponents {
            var components = URLComponents()
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
