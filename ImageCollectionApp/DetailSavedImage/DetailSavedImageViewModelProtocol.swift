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
    
    init(image: SaveImage)
    
    func deleteFromFavoriteButtonTapped()
    
    func getImageData(completion: @escaping(Data) -> Void)
}

class DetailSavedImageViewModel: DetailSavedImageViewModelProtocol {
    
    private let image: SaveImage
    
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
    
    func getImageData(completion: @escaping (Data) -> Void) {
        NetworkManager.shared.fetchImage(from: image.image) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
