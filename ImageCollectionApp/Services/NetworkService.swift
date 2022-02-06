//
//  NetworkService.swift
//  ImageCollectionApp
//
//  Created by Александр on 05/02/2022.
//

import Foundation

class NetworkService {

    static var shared = NetworkService()

    private init() {}

    func request(searchText: String, completion: @escaping(Data?, Error?) -> Void) {
        let parameters = prepareParameters(searchText: searchText)
        guard let url = url(parameters: parameters) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        print(request)

        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func prepareParameters(searchText: String?) -> [String: String] {
        var parameters: [String: String] = [:]
        parameters["query"] = searchText
        parameters["page"] = String(1)
        parameters["per_page"] = String(20)
        return parameters
    }

    private func url(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }

    private func prepareHeaders() -> [String: String]? {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Client-ID S51dor39vIhLVZdY9ZPAVGiI1h0VqcD31CyQv2RAz-4"
        return headers
    }

    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {

        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}


