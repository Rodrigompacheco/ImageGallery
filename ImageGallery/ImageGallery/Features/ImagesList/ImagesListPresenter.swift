//
//  ImagesListPresenter.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

class ImageListPresenter {
    private let service: ImagesInput
    private var imageList: [Image] = []
    private var newImageListToAdd: [Image] = []
    private var fechImagesState: DataState = .initial

    private weak var view: ImagesListView?
    weak var presenterCoordinatorDelegate: ImagesListPresenterCoordinatorDelegate?
    
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
        return imageList.count
    }
    
    func getImage(at index: Int) -> Image? {
        guard index < imageList.count else { return nil }
        
        return imageList[index]
    }
    
    func isLoading() -> Bool {
        if service.loadingStatus() {
            return true
        }
        return false
    }
    
    func hasMoreToDownload() -> Bool {
        return service.hasMoreToDownloadStatus()
    }
    
    func didSelectImage(at index: Int) {
        guard let image = getImage(at: index) else {
            view?.showAlert("Failed to load the image")
            return
        }
        
        presenterCoordinatorDelegate?.didSelectImage(image: image)
    }
    
    func getOnlyNewImages(images: [Image]) -> [Image] {
        let ids = Set(imageList.map({ $0.id }))
        let result = images.filter { !ids.contains($0.id) }
        return result
    }
}

extension ImageListPresenter: ImagesOutput {
    func requestSucceded(images: [Image], state: DataState) {
        fechImagesState = state
        
        let newImages = getOnlyNewImages(images: images)
        imageList.append(contentsOf: newImages)
        newImageListToAdd = newImages
        
        images.forEach({ image in
            service.fetchImageSizes(id: image.id)
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
        guard let imageIndex = imageList.lastIndex(where: { $0.id == id }) else { return }
        
        imageList[imageIndex].sizes = imageSizes
        view?.reloadData(fechImagesState)
    }
}
