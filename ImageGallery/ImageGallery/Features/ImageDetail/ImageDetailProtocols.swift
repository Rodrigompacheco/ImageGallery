//
//  ImageDetailProtocols.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 01/03/21.
//

import Foundation

protocol ImageDetailView: class {
    func showImage(_ imageUrl: String)
    func showAlert(_ message: String)
}
