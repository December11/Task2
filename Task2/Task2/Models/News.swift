//
//  News.swift
//  Task2
//
//  Created by Alla Shkolnik on 16.07.2022.
//

struct News {
    
    let title: String
    let imageURLString: String
    let shortDescription: String?
    let longDescription: String?
    
}

extension News: Fetchable {
    
}
