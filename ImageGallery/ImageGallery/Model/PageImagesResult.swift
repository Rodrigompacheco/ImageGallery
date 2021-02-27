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
        case images = "photos"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        images = try values.decode(ImagesResult.self, forKey: .images)
    }
    
    init(images: ImagesResult) {
        self.images = images
    }
}

/*
 {
 "photos":
    {
    "page":1,
    "pages":937922,
    "perpage":1,
    "total":"937922",
    "photo":[{
            "id":"50986748756",
            "owner":"91375507@N07",
            "secret":"82f593ff8c",
            "server":"65535",
            "farm":66,
            "title":"still-life 27-02-2021 003",
            "ispublic":1,
            "isfriend":0,
            "isfamily":0
            }]
    },
 "stat":"ok"
 }
 
 
 
 */
