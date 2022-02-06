//
//  CaсhedImageVIew.swift
//  ImageCollectionApp
//
//  Created by Александр on 06/02/2022.
//

import UIKit

class CaсhedImageVIew: UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = UIImage(systemName: "photo")
            return
        }
        
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        NetworkManager.shared.fetchPoster(from: url) { [unowned self] data, response in
            image = UIImage(data: data)
            saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
