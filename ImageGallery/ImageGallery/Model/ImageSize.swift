//
//  ImageSize.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct ImageSize: Codable {
    let label: String
    let width: Double
    let height: Double
    let source: String
    let url: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decode(String.self, forKey: .label)
        width = try values.decode(Double.self, forKey: .width)
        height = try values.decode(Double.self, forKey: .height)
        source = try values.decode(String.self, forKey: .source)
        url = try values.decode(String.self, forKey: .url)
    }
    
    init(label: String, width: Double, height: Double, source: String, url: String) {
        self.label = label
        self.width = width
        self.height = height
        self.source = source
        self.url = url
    }
}
