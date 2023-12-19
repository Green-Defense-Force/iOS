//
//  StoreViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/10/23.
//

import UIKit

class StoreViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = true
        container.backgroundColor = .clear
        return container
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "storeModal")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.isUserInteractionEnabled = true
        return backgroundImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Store"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "storeCloseBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 탭 뷰
    lazy var storeTap: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // 활성화 시켜야 스크롤 가능, 버튼 클릭 가능
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var storeWrappBtn: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var storeTapBoxImg: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "storeTap"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var storeTapBtn: [UIButton] = {
        let storeItemTap: [String] = ["Hair", "Top", "Pants", "Shoes", "Weapon", "Acc"]
        var storeBtn = [UIButton]()
        
        storeItemTap.forEach {
            let btn = UIButton()
            btn.addTarget(self, action: #selector(storeTapped), for: .touchUpInside)
            btn.setTitle($0, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            storeBtn.append(btn)
        }
        return storeBtn
    }()
    
    lazy var character: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "storeCharacter")
        return img
    }()
    
    lazy var storeItemBox: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "storeBox")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var coinBox : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "storeShowCoin")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var storeBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "storeChoiceBtn"), for: .normal)
        btn.setTitle("구매하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 스크롤 뷰의 스크롤 인디케이터를 잠깐 보여줌
        storeWrappBtn.flashScrollIndicators()
    }
    
    func setUI() {
        view.backgroundColor = .clear
        
        // 전체 박스
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -150),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // 전체 배경 이미지
        containerView.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        // 전체 배경 요소들
        // 닫기 버튼
        backgroundImageView.addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            closeBtn.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
        ])
        
        // 스토어 제목 표시
        backgroundImageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: closeBtn.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
        ])
        
        // 스토어 항목 탭
        backgroundImageView.addSubview(storeTap)
        NSLayoutConstraint.activate([
            storeTap.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            storeTap.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            storeTap.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -20),
            storeTap.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1),
        ])
        
        // 스토어 캐릭터
        backgroundImageView.addSubview(character)
        NSLayoutConstraint.activate([
            character.topAnchor.constraint(equalTo: storeTap.bottomAnchor, constant: 20),
            character.centerXAnchor.constraint(equalTo: storeTap.centerXAnchor),
        ])
        
        // 아이템 목록 창
        backgroundImageView.addSubview(storeItemBox)
        NSLayoutConstraint.activate([
            storeItemBox.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            storeItemBox.topAnchor.constraint(equalTo: character.bottomAnchor, constant: 30)
        ])
        
        // 보유 코인 수량 창
        backgroundImageView.addSubview(coinBox)
        NSLayoutConstraint.activate([
            coinBox.leadingAnchor.constraint(equalTo: storeTap.leadingAnchor),
            coinBox.topAnchor.constraint(equalTo: storeItemBox.bottomAnchor, constant: 20)
        ])
        
        // 구매하기 버튼
        backgroundImageView.addSubview(storeBtn)
        NSLayoutConstraint.activate([
            storeBtn.topAnchor.constraint(equalTo: coinBox.topAnchor),
            storeBtn.bottomAnchor.constraint(equalTo: coinBox.bottomAnchor),
            storeBtn.trailingAnchor.constraint(equalTo: storeTap.trailingAnchor),
        ])
        
        // 스토어 탭 테두리 이미지
        storeTap.addSubview(storeTapBoxImg)
        NSLayoutConstraint.activate([
            storeTapBoxImg.topAnchor.constraint(equalTo: storeTap.topAnchor),
            storeTapBoxImg.bottomAnchor.constraint(equalTo: storeTap.bottomAnchor),
            storeTapBoxImg.leadingAnchor.constraint(equalTo: storeTap.leadingAnchor),
            storeTapBoxImg.trailingAnchor.constraint(equalTo: storeTap.trailingAnchor),
        ])
        
        // 스토어 탭 스크롤 뷰 박스
        storeTap.addSubview(storeWrappBtn)
        NSLayoutConstraint.activate([
            storeWrappBtn.centerYAnchor.constraint(equalTo: storeTap.centerYAnchor),
            storeWrappBtn.bottomAnchor.constraint(equalTo: storeTap.bottomAnchor),
            storeWrappBtn.leadingAnchor.constraint(equalTo: storeTap.leadingAnchor),
            storeWrappBtn.trailingAnchor.constraint(equalTo: storeTap.trailingAnchor),
        ])
        
        var previousButton: UIButton? = nil
        
        storeTapBtn.forEach { button in
            storeWrappBtn.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: storeWrappBtn.topAnchor, constant: 10),
                button.bottomAnchor.constraint(equalTo: storeWrappBtn.bottomAnchor),
                button.widthAnchor.constraint(equalToConstant: 70), // 버튼 너비 고정
                
                previousButton == nil ?
                button.leadingAnchor.constraint(equalTo: storeWrappBtn.leadingAnchor, constant: 10) :
                    button.leadingAnchor.constraint(equalTo: previousButton!.trailingAnchor, constant: 10)
            ])
            
            // 마지막 버튼의 trailingAnchor를 스크롤 뷰의 trailingAnchor에 연결
            if button == storeTapBtn.last {
                NSLayoutConstraint.activate([
                    button.trailingAnchor.constraint(equalTo: storeWrappBtn.trailingAnchor, constant: -10)
                ])
            }
            
            previousButton = button
        }
    }
    
    @objc func storeTapped(sender: UIButton) { // sender 파라미터 추가
        print("\(sender.currentTitle ?? "") 버튼이 눌렸습니다.")
        sender.setBackgroundImage(UIImage(named: "storeTapBtn"), for: .normal)
        
        storeTapBtn.forEach { button in
            if button != sender {
                button.setBackgroundImage(nil, for: .normal)
            }
        }
    }
}
