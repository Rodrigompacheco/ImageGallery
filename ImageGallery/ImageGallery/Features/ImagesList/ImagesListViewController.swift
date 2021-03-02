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
    private var footer: UICollectionReusableView?
    private let footerIdentifier = "footer"
    private let footerElementKind = UICollectionView.elementKindSectionFooter
    
    init(presenter: ImageListPresenter) {
        self.presenter = presenter
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.footerReferenceSize = CGSize(width: 200, height: 100)
        imagesListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImagesListCollectionView()
        presenter.attachView(view: self)
    }
    
    private func setupImagesListCollectionView() {
        view.addSubview(imagesListCollectionView)

        imagesListCollectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        imagesListCollectionView.dataSource = self
        imagesListCollectionView.delegate = self
        imagesListCollectionView.backgroundColor = .clear
        imagesListCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        imagesListCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: footerElementKind, withReuseIdentifier: footerIdentifier)
    }
    
    private func updateUI(dataState: DataState) {
        switch dataState {
        case .initial:
            DispatchQueue.main.async {
                self.imagesListCollectionView.reloadData()
            }
        case .inserted(let indexPaths):
            DispatchQueue.main.async {
                self.imagesListCollectionView.performBatchUpdates({
                    self.imagesListCollectionView.insertItems(at: indexPaths)
                })
            }
        case .loading:
            break
        default:
            break
        }
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case footerElementKind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: footerElementKind,
                                                            withReuseIdentifier: footerIdentifier,
                                                            for: indexPath)
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
}

extension ImagesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Open the image specs
        print(presenter.getImage(at: indexPath.row)!.id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.reachedBottom && !presenter.isLoading() && presenter.hasMoreToDownload()  else { return }
        
        let indexPath = IndexPath(item: 0, section: 0)
        footer = imagesListCollectionView.supplementaryView(forElementKind: footerElementKind, at: indexPath)
        footer?.lock()
        
        presenter.fetchData()
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
    
    func reloadData(_ state: DataState) {
        DispatchQueue.main.async {
            self.footer?.unlock()
            self.updateUI(dataState: state)
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

