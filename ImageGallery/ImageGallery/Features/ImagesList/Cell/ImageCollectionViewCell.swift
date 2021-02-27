//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 27/02/21.
//

import UIKit
import SnapKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: ImageCollectionViewCell.self)
    
    private var cardView = UIView()
    private var pictureImageView = UIImageView()
    
    private var presenter: ImageCollectionCellPresenter?

    func attachPresenter(_ presenter: ImageCollectionCellPresenter) {
        self.presenter = presenter
        presenter.attachView(self)
    }
    
    private func setupCardView() {
        self.addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.top.leading.equalTo(2)
            $0.bottom.trailing.equalTo(-2)
        }
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.7
    }
    
    private func setupPictureImageView() {
        cardView.addSubview(pictureImageView)
        
        pictureImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        pictureImageView.layer.cornerRadius = 10
        pictureImageView.clipsToBounds = true
        pictureImageView.contentMode = .scaleAspectFill
    }
}

extension ImageCollectionViewCell: ImageCollectionCellView {
    func setupView() {
        setupCardView()
        setupPictureImageView()
    }
    
    func setImage(_ photo: String) {
        pictureImageView.load(thumbnailImage: photo)
    }
}
