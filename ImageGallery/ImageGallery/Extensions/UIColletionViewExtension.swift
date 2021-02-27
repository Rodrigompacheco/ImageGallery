//
//  UIColletionViewExtension.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import UIKit

extension UICollectionView {
    var sizeForCards: CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = self.frame.size.width - padding
        let percentageOfWidth: CGFloat = 0.50
        let percentageOfHeight: CGFloat = 0.35
        
        return CGSize(width: collectionViewSize * percentageOfWidth,
                      height: self.frame.height * percentageOfHeight)
    }
}
