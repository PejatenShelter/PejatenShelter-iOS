//
//  Photo.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation

struct Photo: Codable {
    let id: String?
    let urlString: String
    let filename: String?
    let type: String?
    let size: Int?
    let width, height: Int?
    let thumbnails: Thumbnails?
    
    private enum CodingKeys : String, CodingKey {
        case id, filename, type, size, width, height, thumbnails
        case urlString = "url"
    }
    
    lazy var url: URL? = { URL(string: urlString) }()
}

struct Thumbnails: Codable {
    let small: Thumbnail
    let large: Thumbnail
    let full: Thumbnail
}

struct Thumbnail: Codable {
    let urlString: String
    let width, height: Int
    
    private enum CodingKeys : String, CodingKey {
        case width, height
        case urlString = "url"
    }
    
    lazy var url: URL? = { URL(string: urlString) }()
}
