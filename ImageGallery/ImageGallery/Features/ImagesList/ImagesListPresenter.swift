//
//  ImagesListPresenter.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

class ImageListPresenter {
    private let service: ImagesInput
    private var images: [Image] = []

    private weak var view: ImagesListView?
    
    init(service: ImagesInput) {
        self.service = service
        self.service.imagesOutput = self
        self.service.imageSizesOutput = self
    }
    
    func attachView(view: ImagesListView) {
        self.view = view
        fetchData()
    }
    
    func fetchData() {
        service.fetchImages()
    }
    
    func getTotalImages() -> Int {
        return images.count
    }
    
    func getImage(at index: Int) -> Image? {
        guard index < images.count else { return nil }
        
        return images[index]
    }
    
    func isLoading() -> Bool {
        return service.loadingStatus()
    }
    
    func hasMoreToDownload() -> Bool {
        return service.hasMoreToDownloadStatus()
    }
}

extension ImageListPresenter: ImagesOutput {
    func requestSucceded(images: [Image]) {
        self.images = images
        
        images.forEach({
            service.fetchImageSizes(id: $0.id)
        })
    }
    
    func requestFailed(error: APIError) {
        var errorMessage = ""
        
        switch error {
        default:
            errorMessage = "Number of requests exceeded. Try again in 60 minutes."
        }
        view?.showAlert(errorMessage)
    }
}

extension ImageListPresenter: ImageSizesOutput {
    func requestSucceded(imageSizes: [ImageSize], of id: String) {
        guard let imageIndex = images.firstIndex(where: { $0.id == id }) else { return }
        
        images[imageIndex].sizes = imageSizes
        view?.reloadData()
    }
}
