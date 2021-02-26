//
//  ImageSizeResult.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct ImageSizeResult: Codable {
    let sizes: [ImageSize]
    
    enum CodingKeys: String, CodingKey {
        case sizes = "size"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sizes = try values.decode([ImageSize].self, forKey: .sizes)
    }
    
    init(sizes: [ImageSize]) {
        self.sizes = sizes
    }
}
