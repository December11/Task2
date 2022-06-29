//
//  NetworkService.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import Foundation

final class NetworkService {
    
    let session = URLSession.shared
    let scheme = "https"
    let host = "firebasestorage.googleapis.com"
    let path = "/v0/b/books-6bcec.appspot.com/o/books.json"
    let queryItems = [
        URLQueryItem(name: "alt", value: "media"),
        URLQueryItem(name: "token", value: "44a536f2-11ea-42fb-a84b-b665e4e05fff")
    ]
    
    func fetch(completionBlock: @escaping (Result<[BookDTO], Error>) -> Void) {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            components.queryItems = queryItems
            return components
        }
        
        guard let url = urlComponents.url else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let data = data
            else {
                print("## Error. Can't load data: \(String(describing: error))")
                return
            }
            do{
                let json = try JSONDecoder().decode(BookListDTO.self, from: data)
//                print("booksDTO = \(json.books)")
                completionBlock(.success(json.books))
            } catch {
                print("## Error. No items in response")
                completionBlock(.failure(error))
            }
        }
        task.resume()
    }
}