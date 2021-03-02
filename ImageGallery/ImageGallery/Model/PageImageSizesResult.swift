//
//  PageSizesImageResult.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct PageImageSizesResult: Codable {
    let sizes: ImageSizeResult
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sizes = try values.decode(ImageSizeResult.self, forKey: .sizes)
    }
    
    init(sizes: ImageSizeResult) {
        self.sizes = sizes
    }
}
