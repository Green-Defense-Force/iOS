//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/16/23.
//

import UIKit

class HomeViewController: UIViewController {    
    lazy var background: UIImageView = {
        let UIImageView = UIImageView(image: UIImage(named: "gameHome"))
        UIImageView.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.isUserInteractionEnabled = true
        return UIImageView
    }()
    
    lazy var myPage: UIImageView = {
        let UIImageView = UIImageView()
        UIImageView.image = UIImage(named: "myPage")
        UIImageView.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.isUserInteractionEnabled = true
        UIImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToMyPage)))
        
        return UIImageView
    }()
    
    lazy var store: UIImageView = {
        let UIImageView = UIImageView()
        UIImageView.image = UIImage(named: "store")
        UIImageView.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.isUserInteractionEnabled = true
        UIImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToStore)))
        
        return UIImageView
    }()
    
    lazy var inventory: UIImageView = {
        let UIImageView = UIImageView()
        UIImageView.image = UIImage(named: "inventory")
        UIImageView.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.isUserInteractionEnabled = true
        UIImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToInventory)))
        
        return UIImageView
    }()
    
    lazy var GDF: UIImageView = {
        let UIImageView = UIImageView()
        UIImageView.image = UIImage(named: "GDF")
        UIImageView.translatesAutoresizingMaskIntoConstraints = false
        UIImageView.isUserInteractionEnabled = true
        UIImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playGameTap)))
        return UIImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // customTabBar를 다시 표시합니다.
            CustomTabBarViewController.shared.customTabBar.isHidden = false
        }
    
    func setUI() {
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        GDF.contentMode = .scaleAspectFit
        view.addSubview(GDF)
        NSLayoutConstraint.activate([
            GDF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            GDF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            GDF.widthAnchor.constraint(equalToConstant: 75),
            GDF.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        store.contentMode = .scaleAspectFit
        view.addSubview(store)
        NSLayoutConstraint.activate([
            store.topAnchor.constraint(equalTo: GDF.bottomAnchor, constant: 50),
            store.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            store.widthAnchor.constraint(equalToConstant: 75),
            store.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        inventory.contentMode = .scaleAspectFit
        view.addSubview(inventory)
        NSLayoutConstraint.activate([
            inventory.topAnchor.constraint(equalTo: store.bottomAnchor, constant: 50),
            inventory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inventory.widthAnchor.constraint(equalToConstant: 75),
            inventory.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        view.addSubview(myPage)
        NSLayoutConstraint.activate([
            myPage.topAnchor.constraint(equalTo: inventory.bottomAnchor, constant: 50),
            myPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            myPage.widthAnchor.constraint(equalToConstant: 75),
            myPage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    @objc func playGameTap() {
        let mapVC = MapViewController()
        // customTabBar를 숨김
        CustomTabBarViewController.shared.customTabBar.isHidden = true
        navigationController?.pushViewController(mapVC, animated: false)
    }
    
    @objc func goToStore() {
        let storeVC = StoreViewController()
        
        // 모달 프레젠테이션 스타일 설정
        storeVC.modalPresentationStyle = .overFullScreen
        storeVC.modalTransitionStyle = .crossDissolve

        // 모달 뷰 컨트롤러로 표시
        self.present(storeVC, animated: true, completion: nil)
    }
       
       @objc func goToInventory() {
           let inventoryVC = InventoryViewController()
           // customTabBar를 숨김
           CustomTabBarViewController.shared.customTabBar.isHidden = true
           navigationController?.pushViewController(inventoryVC, animated: false)
       }
       
       @objc func goToMyPage() {
           let myPageVC = MyPageViewController()
           // customTabBar를 숨김
           CustomTabBarViewController.shared.customTabBar.isHidden = true
           navigationController?.pushViewController(myPageVC, animated: false)
       }
}
