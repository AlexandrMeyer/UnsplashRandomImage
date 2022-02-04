//
//  DetailSavedImageViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 03/02/2022.
//

import Foundation

protocol DetailSavedImageViewModelProtocol {
    var imageData: Data? { get }
    var authorName: String { get }
    var descriptionLabel: String { get }
    
    init(image: SaveImage)
    
    func deleteFromFavoriteButtonTapped()
}

class DetailSavedImageViewModel: DetailSavedImageViewModelProtocol {
    
    private let image: SaveImage
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: image.image)
    }
    
    var authorName: String {
        image.authorName ?? ""
    }
    
    var descriptionLabel: String {
                     """
        Author: \(image.authorName ?? "")
        
        Date of creation: \(image.creationData ?? "")
        
        Location: \(image.location ?? "")
        
        Number of downloads: \(image.loadingCount)
        """
    }
    
    required init(image: SaveImage) {
        self.image = image
    }
    
    func deleteFromFavoriteButtonTapped() {
        StorageManager.shared.delete(image)
    }
}
