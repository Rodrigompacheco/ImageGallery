//
//  ImageSize.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct ImageSize: Codable {
    let label: String
    let source: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decode(String.self, forKey: .label)
        source = try values.decode(String.self, forKey: .source)
    }
    
    init(label: String, source: String) {
        self.label = label
        self.source = source
    }
}
