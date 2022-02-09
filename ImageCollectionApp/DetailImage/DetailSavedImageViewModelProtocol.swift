//
//  DetailSavedImageViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 03/02/2022.
//

import Foundation

protocol DetailSavedImageViewModelProtocol {
    var authorName: String { get }
    var descriptionLabel: String { get }
    
    init(savedImage: SaveImage)
    
    func deleteFromFavoriteButtonTapped()
    func getCachedImageData(completion: @escaping(Data) -> Void)
}

class DetailSavedImageViewModel: DetailSavedImageViewModelProtocol {
    
    private let savedImage: SaveImage
    
    var authorName: String {
        savedImage.authorName ?? ""
    }
    
    var descriptionLabel: String {
                     """
        Author: \(savedImage.authorName ?? "")
        
        Date of creation: \(savedImage.creationData ?? "")
        
        Location: \(savedImage.location ?? "")
        
        Number of downloads: \(savedImage.loadingCount)
        """
    }
    
    required init(savedImage: SaveImage) {
        self.savedImage = savedImage
    }
    
    func deleteFromFavoriteButtonTapped() {
        StorageManager.shared.delete(savedImage)
    }
    
    func getCachedImageData(completion: @escaping(Data) -> Void) {
        CaсhedData.shared.fetchData(from: savedImage.image ?? "") { data in
            completion(data)
        }
    }
}
