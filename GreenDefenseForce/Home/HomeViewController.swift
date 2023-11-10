//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBlackTitleWhiteBg(title: "게임")
    }
}

extension UIViewController {
    func setNavigationBlackTitleWhiteBg(title: String) {
        view.backgroundColor = .white
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
