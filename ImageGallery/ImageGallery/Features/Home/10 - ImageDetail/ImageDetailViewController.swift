//
//  ImageDetailViewController.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 01/03/21.
//

import UIKit
import SnapKit

class ImageDetailViewController: UIViewController {
    
    private let bannerImageView = UIImageView()
    private let presenter: ImageDetailPresenter
    
    init(presenter: ImageDetailPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBannerImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        presenter.attachView(view: self)
    }

    private func setupBannerImageView() {
        view.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        bannerImageView.contentMode = .scaleAspectFit
    }
}

extension ImageDetailViewController: ImageDetailView {
    func showImage(_ imageUrl: String) {
        if imageUrl.isEmpty {
            bannerImageView.image = UIImage(named: "noImagePlaceholder")
        } else {
            bannerImageView.load(thumbnailImage: imageUrl)
        }
    }
    
    func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}


