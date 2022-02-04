//
//  Image.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

struct Image: Decodable {
    let creationData: String?
    let urls: URLS?
    let user: User?
    let links: Link?
    let likes: Int?
    
    enum CodingKeys: String, CodingKey {
        case creationData = "created_at"
        case urls
        case user
        case links
        case likes
    }
}

struct URLS: Decodable {
    let small: String?
    let regular: String?
}

struct User: Decodable {
    let name: String?
}

struct Link: Decodable {
    let downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case downloadLocation = "download_location"
    }
}
