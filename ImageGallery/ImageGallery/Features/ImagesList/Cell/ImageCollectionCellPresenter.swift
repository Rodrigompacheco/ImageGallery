//
//  ImageCollectionCellPresenter.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

class ImageCollectionCellPresenter {
    private weak var view: ImageCollectionCellView?
    private let image: Image
    
    init(image: Image) {
        self.image = image
    }
    
    func attachView(_ view: ImageCollectionCellView) {
        self.view = view
        setupView()
    }

    func setupView() {
        view?.setupView()
        view?.setImage(image.getUrl(for: .medium))
    }
}
