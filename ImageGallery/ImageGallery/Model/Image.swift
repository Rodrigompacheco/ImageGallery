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
    var sizes: [ImageSize] = []
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
    }
      
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    func getUrl() -> String {
        return getUrl(for: .medium) ?? getUrl(for: .large) ?? getUrl(for: .small) ?? getUrl(for: .thumbnail) ?? getUrl(for: .square) ?? ""
    }
    
    private func getUrl(for size: Size) -> String? {
        for imageSize in sizes {
            if imageSize.label == size.rawValue {
                return imageSize.source
            }
        }
        
        return nil
    }
}
