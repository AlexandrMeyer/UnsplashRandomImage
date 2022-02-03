//
//  ImageManager.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: String?) -> Data? {
        guard let url = URL(string: url ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        
        return imageData
    }
}
