//
//  Paginator.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 28/02/21.
//

import Foundation

final class Paginator {//<T> where T: Decodable {
    var hasMore = true
    var isLoading = false
    var offset = 1
    var results: [Image] = []
    
    func paginate(dataPackage: ImagesResult) -> DataState {
        let lastResultIndex = self.results.count
        
        let ids = results.map({ $0.id })
        let set = Set(ids)
        let result = dataPackage.images.filter { !set.contains($0.id) }
        self.results += result
        
        let indexPaths = (lastResultIndex..<self.results.count).map { IndexPath(row: $0, section: 0) }
        let changeState: DataState = self.offset == 1 ? .initial : .inserted(indexPaths)
        self.offset += 1
        self.hasMore = self.results.count < Int(dataPackage.totalImages) ?? 0
        self.isLoading = false
        return changeState
    }
}
