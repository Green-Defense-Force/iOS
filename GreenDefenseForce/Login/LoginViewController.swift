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
    let loginLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginLogo")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let logoTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "도전! 환경 지킴 방범대"
            label.font = .systemFont(ofSize: 30, weight: .bold)
            return label
        }()
        
        let loginLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "소셜 로그인"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            return label
        }()
        
        image.addSubview(logoTitle)
        image.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            logoTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            logoTitle.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: logoTitle.bottomAnchor, constant: 50),
            loginLabel.centerXAnchor.constraint(equalTo: logoTitle.centerXAnchor)
        ])
        return image
    }()
    
   
    
    let btnContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .scaleAspectFit
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
    
    lazy var kakaoLoginBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "kakaoLogin"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(kakaoLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    
    lazy var googleLoginBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "googleLogin"), for: .normal)
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
        view.addSubview(loginLogo)
        view.addSubview(btnContainer)
        
        btnContainer.addArrangedSubview(kakaoLoginBtn)
        btnContainer.addArrangedSubview(googleLoginBtn)
        
        NSLayoutConstraint.activate([
            loginLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            btnContainer.topAnchor.constraint(equalTo: loginLogo.bottomAnchor, constant: 200),
            btnContainer.centerXAnchor.constraint(equalTo: loginLogo.centerXAnchor)
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
