//
//  UIImageViewExtension.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(thumbnailImage: String) {
        let url = URL(string: thumbnailImage)
        kf.indicatorType = .activity
        lock()
        kf.setImage(with: url, completionHandler: { [weak self] (_, _, _, _) in
            guard let self = self else { return }
            self.unlock()
        })
    }
}
