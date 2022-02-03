//
//  ImageCellListViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 03/02/2022.
//

import Foundation

protocol ImageCellListViewModelProtocol {
    var imageData: Data? { get }
    var label: String? { get }
    init(image: SaveImage?)
}

class ImageCellListViewModel: ImageCellListViewModelProtocol {
    
    private let savedImage: SaveImage?
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: savedImage?.image)
    }
    
    var label: String? {
        savedImage?.authorName ?? ""
    }
    
    required init(image: SaveImage?) {
        self.savedImage = image
    }
}
