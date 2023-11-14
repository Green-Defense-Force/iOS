//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    var imageView: [UIImageView] = []
    var viewModel = HomeViewModel()
    var alterImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        viewModel.fetchImage()
        attackMonster()
    }
    
    func setUI() {
        
        setNavigationBlackTitleWhiteBg(title: "게임")
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        
        let numberOfImageViews = 4
        
        imageView = (0...numberOfImageViews).map{ _ in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            return imageView
        }
       
        imageView[3].alpha = 0.0
        
        // 맵
        NSLayoutConstraint.activate([
            imageView[0].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView[0].centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -45),
            imageView[0].widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView[0].heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        // 유저 캐릭터
        NSLayoutConstraint.activate([
            imageView[1].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            imageView[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView[3].bottomAnchor.constraint(equalTo: imageView[1].bottomAnchor),
            imageView[3].leadingAnchor.constraint(equalTo: imageView[1].leadingAnchor)
            
        ])
        
        // 몬스터
        NSLayoutConstraint.activate([
            imageView[2].bottomAnchor.constraint(equalTo: imageView[1].bottomAnchor, constant: 50),
            imageView[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    func bind() {
        viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                for (index, image) in images.enumerated() {
                    self?.imageView[index].image = image
                }
            }
            .store(in: &subscriptions)
    }
    
    func attackMonster() {
        let attack = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(attack)
    }
    
    @objc func handleTap() {
        print("tap")
        alterImage.toggle()
        
        UIView.animate(withDuration: 0.0, animations:  {
            self.imageView[1].alpha = self.alterImage ? 0.0 : 1.0
            self.imageView[3].alpha = self.alterImage ? 1.0 : 0.0
        }) {_ in
            self.imageView[1].alpha = 1
            self.imageView[3].alpha = 0
        }
    }
}
