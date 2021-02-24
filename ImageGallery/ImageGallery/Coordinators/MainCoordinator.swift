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
        let viewController = ViewController()
        viewController.title = "Repositórios"
        viewController.view.backgroundColor = AppColorPalette.mainBackground
        navigationController.pushViewController(viewController, animated: false)
    }
}
