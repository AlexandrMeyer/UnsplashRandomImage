//
//  ImageCellCollectionViewModelProtocol.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

protocol ImageCellCollectionViewModelProtocol {
    init(image: Image?)
    
    func getImageData(completion: @escaping(Data) -> Void)
}

class ImageCellCollectionViewModel: ImageCellCollectionViewModelProtocol {
    
    private let image: Image?
    
    required init(image: Image?) {
        self.image = image
    }
    
    func getImageData(completion: @escaping(Data) -> Void) {
        CaсhedData.shared.fetchData(from: image?.urls?.small ?? "") { data in
            completion(data)
        }
    }
}
