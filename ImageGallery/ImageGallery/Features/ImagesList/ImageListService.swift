//
//  ImageListService.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

class ImageListService: ImagesInput {
    var output: ImagesOutput?
    
    func fetchImages() {
        
    }
    
    func loadingStatus() -> Bool {
        return false
    }
    
    func hasMoreToDownloadStatus() -> Bool {
        return false
    }
}
