//
//  DataPackage.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 28/02/21.
//

import Foundation

struct DataPackage<T>: Decodable where T: Decodable {
    let totalCount: Int
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
