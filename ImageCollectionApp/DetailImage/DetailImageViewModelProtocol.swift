//
//  DetailImageViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol DetailImageViewModelProtocol {
    var imageData: Data? { get }
    var authorName: String { get }
    var descriptionLabel: String { get }
    
    init(image: Image)
    
    func addToFavoriteButtonTapped()
}

class DetailImageViewModel: DetailImageViewModelProtocol {
    
    private let image: Image
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: image.urls.regular)
    }
    
    var authorName: String {
        image.user.name
    }
    
    var descriptionLabel: String {
                     """
        Author: \(image.user.name)

        Date of creation: \(image.creationData)

        Location: \(image.links.downloadLocation)

        Number of downloads: \(image.likes ?? 0)
        """
    }
    
    required init(image: Image) {
        self.image = image
    }
    
    func addToFavoriteButtonTapped() {
        StorageManager.shared.save(image)
    }
}
