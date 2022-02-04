//
//  RandomImageCollectionViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol RandomImageCollectionViewModelProtocol {
    var title: String { get }
    var isFiltering: Bool { get }
    func filterContentForSearchText(_ searchText: String, completion: @escaping() -> Void)
    func fetchImages(completion: @escaping() -> Void)
    func numberOfItems() -> Int
    func cellViewModel(at indexpath: IndexPath) -> ImageCellCollectionViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> DetailImageViewModelProtocol
}

class RandomImageCollectionViewModel: RandomImageCollectionViewModelProtocol {
    
    var title: String = "Images Collection"
    
    private var images: [Image]?
    private var filteredImages: [Image] = []
    
    var isFiltering: Bool {
        SearchController.shared.searchController.isActive && !SearchController.shared.searchBarIsEmpty
    }
    
    private func getImageAt(_ indexPath: IndexPath) -> Image? {
        isFiltering ? filteredImages[indexPath.item] : images?[indexPath.item]
    }
    
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        filteredImages = images?.filter{ image in
            image.user!.name!.lowercased().contains(searchText.lowercased())
        } ?? []
        completion()
    }
    
    func fetchImages(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchImageInfo { [weak self] result in
            switch result {
            case .success(let image):
                self?.images = image
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        isFiltering ? filteredImages.count : images?.count ?? 0
    }
    
    func cellViewModel(at indexpath: IndexPath) -> ImageCellCollectionViewModelProtocol {
        let image = getImageAt(indexpath)
        return ImageCellCollectionViewModel(image: image)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> DetailImageViewModelProtocol {
        let image = getImageAt(indexPath)
        return DetailImageViewModel(image: image)
    }
}
