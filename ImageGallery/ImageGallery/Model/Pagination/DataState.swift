//
//  DataState.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 28/02/21.
//

import Foundation

enum DataState {
    case notLoaded
    case loading
    case initial
    case inserted([IndexPath])
    case error(APIError)
}
