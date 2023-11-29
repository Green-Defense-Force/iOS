//
//  CustomTabBarViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/27/23.
//

import UIKit

class CustomTabBarViewController: UIViewController, CustomTabBarDelegate {

    static var shared: CustomTabBarViewController!
    
    var selectedViewController: UIViewController?
    let customTabBar = CustomTabBar()
    
    let challengeVC = UINavigationController(rootViewController: ChallengeViewController())
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let ploggingVC = UINavigationController(rootViewController: PloggingViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomTabBarViewController.shared = self
        customTabBar.delegate = self
        
        view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        selectTab(index: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.customTabBar.isHidden = true
    }
    
    func tabBar(tabBar: CustomTabBar, index: Int) {
        selectTab(index: index)
    }
    
    func selectTab(index: Int) {
        if let vc = selectedViewController {
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        
        let vc: UIViewController
        switch index {
        case 0:
            vc = challengeVC
        case 1:
            vc = homeVC
        case 2:
            vc = ploggingVC
        default:
            return
        }
        
        addChild(vc)
        view.insertSubview(vc.view, at: 0)
        vc.view.frame = view.bounds
        vc.didMove(toParent: self)
        
        selectedViewController = vc
    }
}
