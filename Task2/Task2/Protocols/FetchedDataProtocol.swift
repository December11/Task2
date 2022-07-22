//
//  FetchedDataProtocol.swift
//  Task2
//
//  Created by Alla Shkolnik on 16.07.2022.
//

protocol FetchedDataProtocol {
    
    var title: String? { get set }
    var imageURLString: String? { get set }
    var shortDescription: String? { get set }
    var longDescription: String? { get set }
    
    init(title: String?, imageURLString: String?, shortDescription: String?, longDescription: String?)
    
}
