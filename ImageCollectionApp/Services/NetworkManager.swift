//
//  NetworkManager.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

enum DecodingError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let api = "https://api.unsplash.com/photos?page=1&client_id=S51dor39vIhLVZdY9ZPAVGiI1h0VqcD31CyQv2RAz-4"
    
    private init() {}
    
    func fetchImageInfo(compleation: @escaping(Result<[Image], DecodingError>) -> Void) {
        
        guard let url = URL(string: api) else {
            compleation(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                compleation(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let imageInfo = try jsonDecoder.decode([Image].self, from: data)
                DispatchQueue.main.async {
                    compleation(.success(imageInfo))
                }
            } catch {
                compleation(.failure(.decodingError))
            }
        }.resume()
    }
}
