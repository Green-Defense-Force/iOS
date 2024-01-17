//
//  LoginViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 1/15/24.
//

import UIKit
import PinLayout
import FlexLayout
import KakaoSDKUser
import KakaoSDKCommon
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    let container: UIView = {
        let view = UIView()
        return view
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginLogo")
        image.accessibilityLabel = "로고 이미지"
        image.contentMode = .scaleAspectFit // 이미지 컨텐트 모드 설정
        return image
    }()
    
    let gdfTitle: UILabel = {
        let label = UILabel()
        label.text = "도전! 환경 지킴 방범대"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "소셜 로그인"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let btnContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var kakaoAuthVM: KakaoAuthVM = {
        let vm = KakaoAuthVM()
        vm.onLoginSuccess = {
            self.switchToMainScreen()
        }
        return vm
    }()
    
    lazy var googleAuthVM: GoogleAuthVM = {
        let vm = GoogleAuthVM()
        vm.onLoginSuccess = {
            self.switchToMainScreen()
        }
        return vm
    }()
    
    lazy var kakaoLoginBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "kakaoLogin"), for: .normal)
        button.addTarget(self, action: #selector(kakaoLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var googleLoginBtn: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        button.addTarget(self, action: #selector(googleLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        container.pin.center().width(80%).height(70%)
        container.flex.layout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        btnContainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(googleLoginBtn).width(250).height(45).marginBottom(10)
            flex.addItem(kakaoLoginBtn).width(250).height(45)
        }
        container.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(logoImage).height(200).margin(20)
            flex.addItem(gdfTitle).marginBottom(10)
            flex.addItem(loginLabel).marginBottom(30)
            flex.addItem(btnContainer)
        }
        view.addSubview(container)
    }
    
    private func switchToMainScreen() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            let mainVC = CustomTabBarViewController()
            sceneDelegate.changeRootViewController(to: mainVC, animated: true)
        }
    }
    
    @objc func kakaoLoginBtnClicked() {
        print("로그인 버튼 클릭")
        kakaoAuthVM.handleKakaoLogin()
    }
    
    
    @objc func googleLoginBtnClicked() {
        googleAuthVM.googleLogin(presentingViewController: self)
    }
}
