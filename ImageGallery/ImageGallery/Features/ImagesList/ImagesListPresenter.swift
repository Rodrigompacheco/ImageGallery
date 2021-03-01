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
    private var imageSizesRequestsCount = 0
    private var isLoadingSizes = false

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
        isLoadingSizes = true
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
        if service.loadingStatus() {//|| isLoadingSizes {
            return true
        }
        return false
    }
    
    func hasMoreToDownload() -> Bool {
        return service.hasMoreToDownloadStatus()
    }
    
    func addNewImages(images: [Image]) {
        for image in images {
            if !imageList.contains(where: { $0.id == image.id}) {
                imageList.append(image)
            }
        }
    }
}

extension ImageListPresenter: ImagesOutput {
    func requestSucceded(images: [Image], state: DataState) {
//        addNewImages(images: images)

        let ids = imageList.map({ $0.id })
        let set = Set(ids)
        let result = images.filter { !set.contains($0.id) }
        imageList.append(contentsOf: result)
        newImageListToAdd = result
        
        fechImagesState = state
        print("\nQuantidade de ids no array agora: \(imageList.count)")
        
//        service.fetchImageSizes(id: newImageListToAdd.first!.id)

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
    func requestSucceded(imageSizes: [ImageSize], of id: String, state: DataState) {
        guard let imageIndex = imageList.lastIndex(where: { $0.id == id }) else { return }

        imageSizesRequestsCount += 1
//        if !imageSizes.isEmpty && imageList[imageIndex].sizes.isEmpty {
            imageList[imageIndex].sizes = imageSizes
            print("INDEX: \(imageIndex)    -    ID: \(id)    -   SIZES: \(imageSizes.count)   -   TEM URL: \(imageList[imageIndex].hasUrl())")
//        }

//        if imageSizesRequestsCount == newImageListToAdd.count {
//            isLoadingSizes = false
            view?.reloadData(fechImagesState)
//            imageSizesRequestsCount = 0
//        } else {
//            print("ID do PRÓX: ", newImageListToAdd[imageSizesRequestsCount].id)
//            service.fetchImageSizes(id: newImageListToAdd[imageSizesRequestsCount].id)
//        }
        
        
    }
}
