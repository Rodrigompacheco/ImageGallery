//
//  ImagesListProtocols.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import Foundation

protocol ImageCollectionCellView: class {
    func setupView()
    func setImage(_ photo: String)
}

protocol ImagesListView: class {
    func updateScrollTopBack(_ status: Bool)
    func reloadData()//_ state: DataState)
    func showAlert(_ message: String)
}

protocol ImagesInput: class {
    var output: ImagesOutput? { get set }
    func fetchImages()
    func loadingStatus() -> Bool
    func hasMoreToDownloadStatus() -> Bool
}

protocol ImagesOutput: class {
    func requestSucceded(images: [Image])//, state: DataState)
    func requestFailed(error: APIError)
}
