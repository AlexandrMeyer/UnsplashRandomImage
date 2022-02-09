//
//  FavoriteImageListViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol FavoriteImageListViewModelProtocol {
    func fetchImage(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func detailsViewModel(at indexPath: IndexPath) -> DetailSavedImageViewModelProtocol
    func cellViewModel(at indexPath: IndexPath) -> ImageCellListViewModelProtocol
    func deleteImage(at indexPath: IndexPath)
}

class FavoriteImageListViewModel: FavoriteImageListViewModelProtocol {
    
    private var savedImages: [SaveImage] = []
    
    func fetchImage(completion: @escaping () -> Void) {
        StorageManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let images):
                self?.savedImages = images
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        savedImages.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellListViewModelProtocol {
        let image = savedImages[indexPath.row]
        return ImageCellListViewModel(image: image)
    }
    
    func deleteImage(at indexPath: IndexPath) {
        let image = savedImages[indexPath.row]
        savedImages.remove(at: indexPath.row)
        StorageManager.shared.delete(image)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> DetailSavedImageViewModelProtocol {
        let image = savedImages[indexPath.row]
        return DetailSavedImageViewModel(savedImage: image)
    }
}
