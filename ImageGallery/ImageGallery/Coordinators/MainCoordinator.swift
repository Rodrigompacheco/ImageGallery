//
//  MainCoordinator.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 24/02/21.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = AppColorPalette.navigationBarColor
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let presenter = ImageListPresenter(service: ImageListService())
        presenter.presenterCoordinatorDelegate = self
        let viewController = ImagesListViewController(presenter: presenter)
        viewController.title = "Images"
        viewController.view.backgroundColor = AppColorPalette.mainBackground
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: ImagesListPresenterCoordinatorDelegate {
    func didSelectImage(image: Image) {
        let presenter = ImageDetailPresenter(image: image)
        let viewController = ImageDetailViewController(presenter: presenter)
        viewController.view.backgroundColor = AppColorPalette.mainBackground
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
