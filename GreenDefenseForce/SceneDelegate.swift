//
//  SceneDelegate.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit
import KakaoSDKAuth
import GoogleSignIn
import FirebaseAuth
import KakaoSDKUser

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let mainVC = CustomTabBarViewController()
      
        if Auth.auth().currentUser != nil {
           
            window?.rootViewController = mainVC
            print("이미 구글 로그인에 성공하였습니다.")
            
            if let currentUser = Auth.auth().currentUser {
                print("현재 로그인된 사용자: \(currentUser.email ?? "이메일 없음")")
            }
        } else {
            let login = LoginViewController()
            UserApi.shared.me { [weak self] user, error in
                if let error = error {
                    print("카카오 로그인 에러: \(error)")
                    self?.window?.rootViewController = login
                } else if let user = user {
                    print("Kakao 로그인 사용자: \(user.kakaoAccount?.email ?? "이메일이 존재하지 않습니다")")
                    self?.window?.rootViewController = mainVC
                } else {
                    self?.window?.rootViewController = login
                }
            }
        }
        window?.makeKeyAndVisible()
    }
    
    // iOS 13이상 로그인 설정
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            // 구글
            let _ = GIDSignIn.sharedInstance.handle(url)
            
            // 카카오
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}

