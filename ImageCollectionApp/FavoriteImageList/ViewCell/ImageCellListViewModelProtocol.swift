//
//  ImageCellListViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 03/02/2022.
//

import Foundation

protocol ImageCellListViewModelProtocol {
    var label: String? { get }
    init(image: SaveImage?)
    
    func getImageData(completion: @escaping(Data) -> Void)
}

class ImageCellListViewModel: ImageCellListViewModelProtocol {
    
    private let savedImage: SaveImage?
    
    var label: String? {
        savedImage?.authorName ?? ""
    }
    
    required init(image: SaveImage?) {
        self.savedImage = image
    }
    
    func getImageData(completion: @escaping(Data) -> Void) {
        CaсhedData.shared.fetchData(from: savedImage?.image ?? "") { data in
            completion(data)
        }
    }
}
