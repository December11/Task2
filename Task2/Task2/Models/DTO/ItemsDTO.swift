//
//  BookDTO.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

struct ItemsDTO<TypeDTO: Decodable>: Decodable {
    
    let items: [TypeDTO]
    
}
