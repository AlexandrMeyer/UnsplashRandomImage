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
    private var filteredImages: Images?
    var timer = Timer()
    
    var isFiltering: Bool {
        SearchController.shared.searchController.isActive && !SearchController.shared.searchBarIsEmpty
    }
    
    private func getImageAt(_ indexPath: IndexPath) -> Image? {
        isFiltering ? filteredImages?.results[indexPath.item] : images?[indexPath.item]
    }
    
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> Void) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            NetworkManager.shared.fetchSearchBarImage(searchText: searchText) { [weak self] result in
                switch result {
                case .success(let images):
                    if images?.results.count != 0 {
                        self?.filteredImages = images
                        self?.images = images?.results
                        completion()
                    } else {
                        self?.fetchImages(completion: completion)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
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
        isFiltering ? filteredImages?.results.count ?? 0 : images?.count ?? 0
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
