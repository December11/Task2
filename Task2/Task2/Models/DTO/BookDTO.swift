//
//  BookDTO.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

struct BookDTO {
    
    let title: String?
    let imageURLString: String?
    let shortDescription: String?
    let longDescription: String?
    
}

extension BookDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURLString = "thumbnailUrl"
        case shortDescription
        case longDescription
    }
    
}

