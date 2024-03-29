//
//  ImagesResult.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct ImagesResult: Codable {
    let totalImages: String
    let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case totalImages = "total"
        case images = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalImages = try values.decode(String.self, forKey: .totalImages)
        images = try values.decode([Image].self, forKey: .images)
    }
    
    init(totalImages: String, images: [Image]) {
        self.totalImages = totalImages
        self.images = images
    }
}
