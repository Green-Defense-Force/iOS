//
//  MainTabBarController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/10/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let challengeNC = UINavigationController(rootViewController: ChallengeViewController())
        let homeNC = UINavigationController(rootViewController: HomeViewController())
        let ploggingNC = UINavigationController(rootViewController: PloggingViewController())
        
        self.viewControllers = [challengeNC, homeNC, ploggingNC]
        
        let challengeTabBarItem = UITabBarItem(title: "챌린지", image: UIImage(systemName: "flag.2.crossed")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 0)
        let homeTabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 2)
        let ploggingTabBarItem = UITabBarItem(title: "플로깅", image: UIImage(systemName: "figure.walk")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 1)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .lightGray
        tabBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        challengeNC.tabBarItem = challengeTabBarItem
        homeNC.tabBarItem = homeTabBarItem
        ploggingNC.tabBarItem = ploggingTabBarItem
        
        self.selectedIndex = 1
    }
}
