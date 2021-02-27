//
//  ViewController.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 23/02/21.
//

import UIKit
import SnapKit

class ImagesListViewController: UIViewController {
    
    private var imagesListCollectionView: UICollectionView!
    private let presenter: ImageListPresenter
    
    init(presenter: ImageListPresenter) {
        self.presenter = presenter
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        imagesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagesListCollectionView()
        presenter.attachView(view: self)
    }
    
    func setupImagesListCollectionView() {
        view.addSubview(imagesListCollectionView)

        imagesListCollectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        imagesListCollectionView.dataSource = self
        imagesListCollectionView.delegate = self
        imagesListCollectionView.backgroundColor = .clear
        imagesListCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
}

extension ImagesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getTotalImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell {
            guard let image = presenter.getImage(at: indexPath.row) else { return defaultCell }
            
            let imageCollectionCellPresenter = ImageCollectionCellPresenter(image: image)
            cell.attachPresenter(imageCollectionCellPresenter)
            
            return cell
        }
        
        return defaultCell
    }
}

extension ImagesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Open the image specs
    }
}

extension ImagesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.sizeForCards
    }
}

extension ImagesListViewController: ImagesListView {
    func updateScrollTopBack(_ status: Bool) {
        //TODO: Feature to scroll to the begining of the list (top)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.imagesListCollectionView.reloadData()
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

