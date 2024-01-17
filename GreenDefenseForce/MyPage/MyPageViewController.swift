//
//  ProfilViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/10/23.
//

import UIKit

class MyPageViewController: UIViewController {
    lazy var googleAuthVM: GoogleAuthVM = {
            let vm = GoogleAuthVM()
            vm.onLogoutSuccess = { [weak self] in
                self?.switchToLoginScreen()
            }
            return vm
        }()

        lazy var kakaoAuthVM: KakaoAuthVM = {
            let vm = KakaoAuthVM()
            vm.onLogoutSuccess = { [weak self] in
                self?.switchToLoginScreen()
            }
            return vm
        }()
    
    lazy var logoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.configuration = .borderedTinted()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(LogoutBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBlackTitleWhiteBg(title: "마이페이지")
        setUI()
    }
    
    func setUI() {
        view.addSubview(logoutBtn)
        NSLayoutConstraint.activate([
            logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func switchToLoginScreen() {
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                let loginVC = LoginViewController()
                sceneDelegate.changeRootViewController(to: loginVC, animated: true)
            }
        }
    
    @objc func LogoutBtnClicked() {
        print("로그아웃 버튼 클릭")
        kakaoAuthVM.handleKakaoLogout()
        googleAuthVM.googleLogout()
    }
}
