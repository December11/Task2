//
//  Book.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

final class Book: Fetchable {
    
    var title: String
    var imageURLString: String
    var shortDescription: String?
    var longDescription: String?
    
    required init(title: String, imageURLString: String, shortDescription: String?, longDescription: String?) {
        self.title = title
        self.imageURLString = imageURLString
        self.shortDescription = shortDescription
        self.longDescription = longDescription
    }
}
