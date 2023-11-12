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
        
        print("MainTabBarController - viewDidLoad() called")
        
        let challengeNC = UINavigationController(rootViewController: ChallengeViewController())
        let ploggingNC = UINavigationController(rootViewController: PloggingViewController())
        let homeNC = UINavigationController(rootViewController: HomeViewController())
        let storeNC = UINavigationController(rootViewController: StoreViewController())
        let profilNC = UINavigationController(rootViewController: ProfilViewController())
        
        self.viewControllers = [challengeNC, ploggingNC, homeNC, storeNC, profilNC]
        
        let challengeTabBarItem = UITabBarItem(title: "챌린지", image: UIImage(systemName: "flag.2.crossed"), tag: 0)
        
        let ploggingTabBarItem = UITabBarItem(title: "플로깅", image: UIImage(systemName: "shoe"), tag: 1)
        let homeTabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller"), tag: 2)
        let storeTabBarItem = UITabBarItem(title: "스토어", image: UIImage(systemName: "storefront"), tag: 3)
        let profilTabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), tag: 4)
        
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        
        
        
        challengeNC.tabBarItem = challengeTabBarItem
        ploggingNC.tabBarItem = ploggingTabBarItem
        homeNC.tabBarItem = homeTabBarItem
        storeNC.tabBarItem = storeTabBarItem
        profilNC.tabBarItem = profilTabBarItem
    }
}
