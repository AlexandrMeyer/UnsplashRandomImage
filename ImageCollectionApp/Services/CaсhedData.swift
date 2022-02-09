//
//  CaсhedData.swift
//  ImageCollectionApp
//
//  Created by Александр on 06/02/2022.
//

import Foundation

final class CaсhedData {
    
    static let shared = CaсhedData()
    
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid url")
            return
        }
        
        if let cachedData = getCachedData(from: url) {
           completion(cachedData)
        }
        
        NetworkManager.shared.fetchImage(from: url) { [unowned self] data, response in
            completion(data)
            saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    
    private func getCachedData(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponce = URLCache.shared.cachedResponse(for: request) {
            return cachedResponce.data
        }
        return nil
    }
}
