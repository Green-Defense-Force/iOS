//
//  KakaoAuthVM.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 1/15/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthVM {
    var onLoginSuccess: (() -> Void)?
    
    init() {
        print("kakaoVM init")
    }
    
    func handleKakaoLogin() {
        print("VM카카오로그인")
        
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            //카카오 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    self.onLoginSuccess?()
                    //do something
                    _ = oauthToken
                    // 유저 정보 가져오기
                    UserApi.shared.me { user, error in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("유저 아이디:",user?.id ?? "유저 아이디가 없습니다.")
                            print("유저 이메일:", user?.kakaoAccount?.email ?? "유저 이메일이 없습니다.")
                        }
                    }
                    
                }
            }
        } else {
            //카카오계정으로 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    self.onLoginSuccess?()
                    // 유저 정보 가져오기
                    UserApi.shared.me() {(user, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("유저 아이디:",user?.id ?? "유저 아이디가 없습니다.")
                            print("유저 이메일:", user?.kakaoAccount?.email ?? "유저 이메일이 없습니다.")
                        }
                    }
                }
            }
        }
    }
    
    func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
}
