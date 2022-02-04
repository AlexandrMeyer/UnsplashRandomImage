//
//  ImageCellCollectionViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol ImageCellCollectionViewModelProtocol {
    var imageData: Data? { get }
    init(image: Image?)
}

class ImageCellCollectionViewModel: ImageCellCollectionViewModelProtocol {
    
    private let image: Image?
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: image?.urls?.small)
    }
    
    required init(image: Image?) {
        self.image = image
    }
}
