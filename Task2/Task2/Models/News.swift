//
//  News.swift
//  Task2
//
//  Created by Alla Shkolnik on 16.07.2022.
//

final class News: Fetchable {
    
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
