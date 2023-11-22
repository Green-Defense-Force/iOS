//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/16/23.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var startBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.cornerStyle = .capsule
        button.layer.cornerRadius = 10
        button.setTitle("시작하기", for: .normal)
        button.addTarget(self, action: #selector(playGameTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // 네비게이션 타고 다시 돌아왔을 때 탭바가 보이게
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setUI() {
        view.addSubview(startBtn)
        NSLayoutConstraint.activate([
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func playGameTap() {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
