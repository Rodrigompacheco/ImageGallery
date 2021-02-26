//
//  PageResult.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct PageImagesResult: Codable {
    let images: ImagesResult
    
    enum CodingKeys: String, CodingKey {
        case images = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        images = try values.decode(ImagesResult.self, forKey: .images)
    }
    
    init(images: ImagesResult) {
        self.images = images
    }
}
