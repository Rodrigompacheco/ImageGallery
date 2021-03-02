//
//  ImageDetailPresenter.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 01/03/21.
//

import Foundation

class ImageDetailPresenter {
    
    private let image: Image
    private weak var view: ImageDetailView?
    
    init(image: Image) {
        self.image = image
    }
    
    func attachView(view: ImageDetailView) {
        self.view = view
        
        if let url = image.getUrl(for: .large) {
            view.showImage(url)
        } else {
            view.showAlert("This image doesn't have the large size dimension")
            view.showImage("")
        }
    }
    
}
