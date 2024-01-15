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
    lazy var kakaoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    lazy var googleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    lazy var kakaoAuthVM: KakaoAuthVM = {
        KakaoAuthVM()
    }()
    lazy var googleAuthVM: GoogleAuthVM = {
        GoogleAuthVM()
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
    
    lazy var kakaoLogoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그아웃", for: .normal)
        button.configuration = .borderedTinted()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(kakaoLogoutBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var googleLoginBtn: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleLoginBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var googleLogoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("구글 로그아웃", for: .normal)
        button.configuration = .borderedTinted()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(googleLogoutBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLoginHandler()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(btnContainer)
        btnContainer.addArrangedSubview(kakaoStackView)
        btnContainer.addArrangedSubview(googleStackView)
        kakaoStackView.addArrangedSubview(kakaoLoginBtn)
        kakaoStackView.addArrangedSubview(kakaoLogoutBtn)
        googleStackView.addArrangedSubview(googleLoginBtn)
        googleStackView.addArrangedSubview(googleLogoutBtn)
        
        NSLayoutConstraint.activate([
            btnContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setLoginHandler() {
        googleAuthVM.onLoginSuccess = { [weak self] in
            let customVC = CustomTabBarViewController()
            self?.navigationController?.pushViewController(customVC, animated: true)
        }
        
        kakaoAuthVM.onLoginSuccess = { [weak self] in
                let customVC = CustomTabBarViewController()
                self?.navigationController?.pushViewController(customVC, animated: true)
        }
    }
    
    @objc func kakaoLoginBtnClicked() {
        print("로그인 버튼 클릭")
        kakaoAuthVM.handleKakaoLogin()
    }
    
    @objc func kakaoLogoutBtnClicked() {
        print("로그아웃 버튼 클릭")
        kakaoAuthVM.handleKakaoLogout()
    }
    
    @objc func googleLoginBtnClicked() {
        googleAuthVM.googleLogin(presentingViewController: self)
    }
    
    @objc func googleLogoutBtnClicked() {
        googleAuthVM.googleLogout()
    }
}
