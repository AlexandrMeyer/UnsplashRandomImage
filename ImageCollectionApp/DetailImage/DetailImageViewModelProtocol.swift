//
//  DetailImageViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol DetailImageViewModelProtocol {
    var authorName: String { get }
    var descriptionLabel: String { get }
    
    init(image: Image?)
    
    func addToFavoriteButtonTapped()
    func getImageData(completion: @escaping(Data) -> Void)
}

class DetailImageViewModel: DetailImageViewModelProtocol {
    
    private let image: Image?
    
    var authorName: String {
        image?.user?.name ?? ""
    }
    
    var descriptionLabel: String {
                     """
        Author: \(image?.user?.name ?? "")
        
        Date of creation: \(image?.creationData ?? "")
        
        Location: \(image?.links?.downloadLocation ?? "")
        
        Number of downloads: \(image?.likes ?? 0)
        """
    }
    
    required init(image: Image?) {
        self.image = image
    }
    
    func addToFavoriteButtonTapped() {
        StorageManager.shared.save(image)
    }
    
    func getImageData(completion: @escaping(Data) -> Void) {
        NetworkManager.shared.fetchImage(from: image?.urls?.regular) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
