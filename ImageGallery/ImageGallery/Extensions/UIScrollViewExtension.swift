//
//  UIScrollViewExtension.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 28/02/21.
//

import UIKit

extension UIScrollView {
    var reachedBottom: Bool {
        let height = self.frame.size.height
        let contentYoffset = self.contentOffset.y
        let distanceFromBottom = self.contentSize.height - contentYoffset
        return distanceFromBottom < height
    }
}
