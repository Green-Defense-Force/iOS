//
//  GoogleAuthVM.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 1/15/24.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class GoogleAuthVM {
    
    var onLoginSuccess: (() -> Void)?
    var onLogoutSuccess: (() -> Void)?

    init() {
        print("googleVM init")
    }
    
    func googleLogin(presentingViewController: UIViewController) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] result, error in
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            // 이미 로그인이 된 상태
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("구글 로그인에 실패: \(error.localizedDescription)")
                    return
                } else {
                    print("구글 로그인에 성공했습니다.")
                    self?.onLoginSuccess?()
                }
            }
        }
        
        // 로그인 상태가 변경될 때 호출
        // 여기에 로그인 상태되면 다시 로그인 화면으로 보내는거 만들면 될듯
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("로그인 상태 변경: \(user.email ?? "이메일 없음")")
            } else {
                print("사용자가 로그아웃되었습니다.")
            }
        }
    }
    
    // 구글 로그아웃
    func googleLogout() {
        let firebaseAuth = Auth.auth()
        do {
            print("google Logout")
            try firebaseAuth.signOut()
            self.onLogoutSuccess?()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
