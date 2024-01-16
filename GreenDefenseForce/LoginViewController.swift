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
    lazy var btnContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Green Defense Force"
        return label
    }()
    
    lazy var kakaoLoginBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "kakaoLogin"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(kakaoLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    
    lazy var googleLoginBtn: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(btnContainer)
        btnContainer.addArrangedSubview(kakaoLoginBtn)
        btnContainer.addArrangedSubview(googleLoginBtn)
       
        NSLayoutConstraint.activate([
            btnContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
