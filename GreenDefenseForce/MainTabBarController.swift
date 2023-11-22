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
        let ploggingNC = UINavigationController(rootViewController: PloggingViewController())
        let homeNC = UINavigationController(rootViewController: HomeViewController())
        let storeNC = UINavigationController(rootViewController: StoreViewController())
        let profilNC = UINavigationController(rootViewController: ProfilViewController())
        
        self.viewControllers = [challengeNC, ploggingNC, homeNC, storeNC, profilNC]
        
        let challengeTabBarItem = UITabBarItem(title: "챌린지", image: UIImage(systemName: "flag.2.crossed")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 0)
        let ploggingTabBarItem = UITabBarItem(title: "플로깅", image: UIImage(systemName: "figure.walk")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 1)
        let homeTabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 2)
        let storeTabBarItem = UITabBarItem(title: "스토어", image: UIImage(systemName: "shippingbox")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 3)
        let profilTabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), tag: 4)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .lightGray
        tabBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
               
        
        
        challengeNC.tabBarItem = challengeTabBarItem
        ploggingNC.tabBarItem = ploggingTabBarItem
        homeNC.tabBarItem = homeTabBarItem
        storeNC.tabBarItem = storeTabBarItem
        profilNC.tabBarItem = profilTabBarItem
        
        self.selectedIndex = 2
    }
}
