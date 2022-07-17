//
//  Book.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

struct Book {
    
    let title: String
    let imageURLString: String
    let shortDescription: String?
    let longDescription: String?
    
}

extension Book: Fetchable {
    
}
