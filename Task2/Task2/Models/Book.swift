//
//  Book.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

final class Book {
    let authorName: String
    let name: String
    let description: String
    
    init(name: String, authorName: String, description: String) {
        self.name = name
        self.authorName = authorName
        self.description = description
    }
}
