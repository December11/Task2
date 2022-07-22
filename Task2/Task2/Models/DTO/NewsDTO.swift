//
//  NewsDTO.swift
//  Task2
//
//  Created by Alla Shkolnik on 16.07.2022.
//

struct NewsDTO {
    
    let title: String?
    let shortDescription: String?
    let imageURLString: String?
    let longDescription: String?
    
}

extension NewsDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case shortDescription = "description"
        case imageURLString = "urlToImage"
        case longDescription = "content"
        
    }
    
}
