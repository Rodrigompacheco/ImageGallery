//
//  Image.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 26/02/21.
//

import Foundation

struct Image: Codable {
    let id: String
    let title: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
    }
      
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
