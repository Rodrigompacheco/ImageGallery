//
//  ImageListService.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

class ImageListService {
    var imagesOutput: ImagesOutput?
    var imageSizesOutput: ImageSizesOutput?
    private let paginator: Paginator
    private let api: Provider
    
    init(api: Provider = APIProvider()) {
        self.api = api
        self.paginator = Paginator()
    }
}

extension ImageListService: ImagesInput {
    func fetchImages() {
        let endpoint = APIEndpoint.images(offset: paginator.offset)
        
        paginator.isLoading = true
        
        api.request(for: endpoint) { [weak self] (result: Result<PageImagesResult, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let pageImages):
                let state = self.paginator.paginate(dataPackage: pageImages.images)
                let images = pageImages.images.images
                self.imagesOutput?.requestSucceded(images: images, state: state)
            case .failure(_):
                self.imagesOutput?.requestFailed(error: APIError.makeRequest)
            }
        }
    }
    
    func fetchImageSizes(id: String) {
        let endpoint = APIEndpoint.imageSizes(id: id)
        
        api.request(for: endpoint) { [weak self] (result: Result<PageImageSizesResult, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let pageImageSizes):
                let imageSizes = pageImageSizes.sizes.sizes
                self.imageSizesOutput?.requestSucceded(imageSizes: imageSizes, of: id)
            case .failure(_):
                self.imageSizesOutput?.requestFailed(error: APIError.makeRequest)
            }
        }
    }
    
    func loadingStatus() -> Bool {
        return paginator.isLoading
    }
    
    func hasMoreToDownloadStatus() -> Bool {
        return paginator.hasMore
    }
}
