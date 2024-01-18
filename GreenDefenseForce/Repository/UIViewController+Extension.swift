//
//  Extension.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import UIKit

extension UIViewController {
    func setNavigationBlackTitleWhiteBg(title: String) {
        view.backgroundColor = .white
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func nvLeftItem(image: UIImage, action: Selector , tintColor: UIColor) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem?.tintColor = tintColor
    }
}

