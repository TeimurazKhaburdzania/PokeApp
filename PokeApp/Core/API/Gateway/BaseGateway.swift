//
//  BaseGateway.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import Foundation

class BaseGateway {
    func fetch<Entity: Decodable>(urlStr: String, queryItems: [URLQueryItem]? = nil, completionHandler: @escaping (Result<Entity, Error>) -> Void) {
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(APIError(localizedDescription: "could not intialize URL")))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completionHandler(.failure(APIError(localizedDescription: "could not initialize URLComponents")))
            return
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completionHandler(.failure(APIError(localizedDescription: "could not get url from URL Components")))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                DispatchQueue.main.async {
                    completionHandler(.failure(APIError(localizedDescription: "status code could not be determined")))
                }
                return
            }
            guard statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(APIError(localizedDescription: "Error status code: \(statusCode)")))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(APIError(localizedDescription: "could not get response data")))
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let entity = try decoder.decode(Entity.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(entity))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}

struct APIError: Error {
    let localizedDescription: String
}
