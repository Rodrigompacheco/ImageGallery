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
//    func reloadData(_ state: DataState)
    func showAlert(_ message: String)
}

//protocol RepositoriesInput: class {
//    var output: RepositoriesOutput? { get set }
//    func fetchRepositories()
//    func loadingStatus() -> Bool
//    func hasMoreToDownloadStatus() -> Bool
//}
//
//protocol RepositoriesOutput: class {
//    func requestSucceded(repositories: [Repository], state: DataState)
//    func requestFailed(error: APIError)
//}
