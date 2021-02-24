//
//  APIProvider.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 24/02/21.
//

import Foundation

protocol Provider: class {
    func request<T: Decodable>(for endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class APIProvider: Provider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: APIEndpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let url = try endpoint.makeUrl()

            session.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    let newError = error == nil ? APIError.invalidData : error!
                    completion(.failure(newError))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
