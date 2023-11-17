//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    let viewModel = GameViewModel()
    var imageView: [UIImageView] = []
    var subscriptions = Set<AnyCancellable>()
    var alterImage = false
    
    lazy var hpBar: UIProgressView = {
        let hpBar = UIProgressView()
        hpBar.translatesAutoresizingMaskIntoConstraints = false
        hpBar.progressTintColor = .red
        hpBar.progressViewStyle = .default
        hpBar.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        hpBar.layer.borderWidth = 5
        hpBar.progress = 1
        
        let label = UILabel()
        label.text = "쓰레기 봉투: LV1"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        hpBar.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: hpBar.leadingAnchor),
            label.topAnchor.constraint(equalTo: hpBar.topAnchor, constant: -30)
        ])
        
        return hpBar
    }()
    
    lazy var attackButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("공격", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(attackTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        viewModel.fetchImage()
        setupSwipeGesture()
        view.backgroundColor = UIColor(red: 0.49, green: 0.67, blue: 0.25, alpha: 1.0)
    }
    
    func setUI() {
        
        // NVTitle
        setNavigationBlackTitleWhiteBg(title: "")
        // NVLItem
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        // 받아온 이미지 초기화
        let numberOfImageViews = 10
        
        imageView = (0...numberOfImageViews).map{ _ in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            return imageView
        }
        
        // 유저 캐릭터
        imageView[1].alpha = 0.0
        NSLayoutConstraint.activate([
            imageView[0].widthAnchor.constraint(equalToConstant: 320),
            imageView[0].heightAnchor.constraint(equalToConstant: 320),
            imageView[0].bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -40),
            
            imageView[1].widthAnchor.constraint(equalTo: imageView[0].widthAnchor),
            imageView[1].heightAnchor.constraint(equalTo: imageView[0].heightAnchor),
            imageView[1].bottomAnchor.constraint(equalTo: imageView[0].bottomAnchor),
            imageView[1].leadingAnchor.constraint(equalTo: imageView[0].leadingAnchor)
            
        ])
        
        // 몬스터
        NSLayoutConstraint.activate([
            imageView[2].centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageView[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            imageView[2].widthAnchor.constraint(equalToConstant: 320),
            imageView[2].heightAnchor.constraint(equalToConstant: 320),
        ])
        
        // Hp
        view.addSubview(hpBar)
        NSLayoutConstraint.activate([
            hpBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hpBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            hpBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 공격버튼
        view.addSubview(attackButton)
        NSLayoutConstraint.activate([
            attackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 120),
            attackButton.centerYAnchor.constraint(equalTo: imageView[1].centerYAnchor),
            attackButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            attackButton.heightAnchor.constraint(equalToConstant: 80)
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
    
    func setupSwipeGesture() {
        let swipeGuesture = UISwipeGestureRecognizer(target: self, action: #selector(backTappedButton))
        // 왼쪽에서 오른쪽으로
        swipeGuesture.direction = .right
        view.addGestureRecognizer(swipeGuesture)
    }
    
    @objc func attackTap() {
        alterImage.toggle()
        
        UIView.animate(withDuration:0, animations:  {
            self.imageView[0].alpha = self.alterImage ? 0.0 : 1.0
            self.imageView[1].alpha = self.alterImage ? 1.0 : 0.0
        }) {_ in
            self.imageView[0].alpha = 1
            self.imageView[1].alpha = 0
            self.alterImage = false
            self.damgeHpTap()
        }
    }
    
    @objc func damgeHpTap() {
        var currentProgress = hpBar.progress
        if currentProgress > 0 {
            currentProgress -= 0.1
        }
        hpBar.setProgress(currentProgress, animated: true)
    }
    
    @objc func backTappedButton() {
        navigationController?.popViewController(animated: false)
    }
}
