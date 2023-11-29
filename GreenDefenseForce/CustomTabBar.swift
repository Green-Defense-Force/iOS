//
//  CustomTabBar.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/27/23.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func tabBar(tabBar: CustomTabBar, index: Int)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    
    let challengeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "challengeBtn"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let homeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "tapHomeBtn"), for: .normal)
        button.contentMode = .scaleAspectFit

        return button
    }()
    
    let ploggingBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "ploggingBtn"), for: .normal)
        button.contentMode = .scaleAspectFit

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [challengeBtn, homeBtn, ploggingBtn])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = .lightGray
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        challengeBtn.addTarget(self, action: #selector(tapChallengeBtn), for: .touchUpInside)
        homeBtn.addTarget(self, action: #selector(tapHomeBtn), for: .touchUpInside)
        ploggingBtn.addTarget(self, action: #selector(tapPloggingBtn), for: .touchUpInside)
    }
    
    @objc func tapChallengeBtn() {
        delegate?.tabBar(tabBar: self, index: 0)
        challengeBtn.setBackgroundImage(UIImage(named:"tapChallengeBtn"), for: .normal)
        homeBtn.setBackgroundImage(UIImage(named: "homeBtn"), for: .normal)
        ploggingBtn.setBackgroundImage(UIImage(named: "ploggingBtn"), for: .normal)
    }
    @objc func tapHomeBtn() {
        delegate?.tabBar(tabBar: self, index: 1)
        challengeBtn.setBackgroundImage(UIImage(named:"challengeBtn"), for: .normal)
        homeBtn.setBackgroundImage(UIImage(named: "tapHomeBtn"), for: .normal)
        ploggingBtn.setBackgroundImage(UIImage(named: "ploggingBtn"), for: .normal)
    }
    @objc func tapPloggingBtn() {
        delegate?.tabBar(tabBar: self, index: 2)
        challengeBtn.setBackgroundImage(UIImage(named:"challengeBtn"), for: .normal)
        homeBtn.setBackgroundImage(UIImage(named: "homeBtn"), for: .normal)
        ploggingBtn.setBackgroundImage(UIImage(named: "tapPloggingBtn"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
