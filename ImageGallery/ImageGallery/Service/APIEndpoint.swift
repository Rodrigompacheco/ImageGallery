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
    static let limitPerPage = 15
    
    var path: String {
        switch self {
        case .images:
            return "/services/rest/"
        case .imageData:
            return "/services/rest/"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        switch self {
        case .images(let offset):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: APIEndpoint.apiKey),
                URLQueryItem(name: "tags", value: "kitten"),
                URLQueryItem(name: "page", value: offset.description),
                URLQueryItem(name: "per_page", value: String(APIEndpoint.limitPerPage)),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1")
            ])
        case .imageData(let id):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "method", value: "flickr.photos.getSizes"),
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

/*
 
 
 {
    "photos":
    {
        "page":1,
        "pages":952049,
        "perpage":1,
        "total":"952049",
        "photo":[{
                "id":"50988754171",
                "owner":"97772383@N00",
                "secret":"d0f1be67da",
                "server":"65535",
                "farm":66,
                "title":"DSC00739",
                "ispublic":1,
                "isfriend":0,
                "isfamily":0
          }]
    },
    "stat":"ok"
 }
 
 
 */
