//
//  Coordinator.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 24/02/21.
//

import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
