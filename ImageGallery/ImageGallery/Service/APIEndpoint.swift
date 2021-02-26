//
//  APIEndpoint.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 24/02/21.
//

import Foundation

enum APIEndpoint {
    case images(offset: Int)
    case imageData(id: String)
}

extension APIEndpoint {
    static let baseUrl = "https://api.flickr.com"
    static let apiKey = "f9cc014fa76b098f9e82f1c288379ea1"
    static let limitPerPage = 20
    
    var path: String {
        switch self {
        case .images:
            return "/services/rest/?method=flickr.photos.search"
        case .imageData:
            return "/services/rest/?method=flickr.photos.getSizes"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        switch self {
        case .images(let offset):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "api_key", value: APIEndpoint.apiKey),
                URLQueryItem(name: "tags", value: "kitten"),
                URLQueryItem(name: "page", value: offset.description),
                URLQueryItem(name: "per_page", value: String(APIEndpoint.limitPerPage)),
                URLQueryItem(name: "nojsoncallback", value: "1")
            ])
        case .imageData(let id):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "api_key", value: APIEndpoint.apiKey),
                URLQueryItem(name: "photo_id", value: id),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1")
            ])
        }
        return queryItems
    }

    func makeUrl() throws -> URL {
        var components = URLComponents(string: APIEndpoint.baseUrl + path)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
}
