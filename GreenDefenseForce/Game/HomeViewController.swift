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
    
    // 네비게이션 타고 다시 돌아왔을 때 탭바가 보이게
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setUI() {
        
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(GDF)
        NSLayoutConstraint.activate([
            GDF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            GDF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            GDF.widthAnchor.constraint(equalToConstant: 75),
            GDF.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        view.addSubview(store)
        NSLayoutConstraint.activate([
            store.topAnchor.constraint(equalTo: GDF.bottomAnchor, constant: 50),
            store.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            store.widthAnchor.constraint(equalToConstant: 75),
            store.heightAnchor.constraint(equalToConstant: 75)
        ])
        
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
        navigationController?.pushViewController(mapVC, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goToStore() {
        let storeVC = StoreViewController()
        navigationController?.pushViewController(storeVC, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goToInventory() {
        let inventoryVC = InventoryViewController()
        navigationController?.pushViewController(inventoryVC, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goToMyPage() {
        let myPageVC = MyPageViewController()
        navigationController?.pushViewController(myPageVC, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
