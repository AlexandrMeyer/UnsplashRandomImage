//
//  NetworkManager.swift
//  ImageCollectionApp
//
//  Created by Александр on 02/02/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let api = "https://api.unsplash.com/photos?page=1&client_id=S51dor39vIhLVZdY9ZPAVGiI1h0VqcD31CyQv2RAz-4"
    
    private init() {}
    
    func fetchSearchBarImage(searchText: String, completion: @escaping(Result<Images?, NetworkError>) -> Void) {
        NetworkService.shared.request(searchText: searchText) { data, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let imageInfo = try jsonDecoder.decode(Images.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(imageInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
    
    func fetchImageInfo(completion: @escaping(Result<[Image], NetworkError>) -> Void) {
        
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
    
    func fetchImage(from url: String?, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            complition(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
}
