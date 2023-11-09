//
//  ViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    lazy var testLabel: UILabel = {
        let Label = UILabel()
        Label.text = "테스트"
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
}

