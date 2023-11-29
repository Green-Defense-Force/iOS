//
//  SceneDelegate.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mainViewController = CustomTabBarViewController()
        
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
}

