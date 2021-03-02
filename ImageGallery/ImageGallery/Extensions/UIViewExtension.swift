//
//  UIViewExtension.swift
//  ImageGallery
//
//  Created by Rodrigo Pacheco on 01/03/21.
//

import UIKit

private let activityTag = 1111

extension UIView {
    func lock(style: UIActivityIndicatorView.Style = .large) {
        guard viewWithTag(activityTag) == nil else { return }
        
        let activity = UIActivityIndicatorView(style: style)
        
        activity.tag = activityTag
        activity.hidesWhenStopped = true
        activity.startAnimating()
        activity.color = .white
        addSubview(activity)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    func unlock() {
        guard let view = viewWithTag(activityTag) as? UIActivityIndicatorView else { return }
        view.stopAnimating()
        view.removeFromSuperview()
    }
}
