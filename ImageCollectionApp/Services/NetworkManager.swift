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
    
    func fetchImageInfo(completion: @escaping(Result<[Image], DecodingError>) -> Void) {
        
        guard let url = URL(string: api) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let imageInfo = try jsonDecoder.decode([Image].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(imageInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
