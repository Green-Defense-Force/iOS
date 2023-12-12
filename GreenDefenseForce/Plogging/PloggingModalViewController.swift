//
//  PloggingModalViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/10/23.
//

import UIKit

class PloggingModalViewController: UIViewController {
    
    // 이거 더 공부해보자: 콜백함수
    var onConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        
        let background = UIImageView()
        background.image = UIImage(named: "ploggingModal")
        background.isUserInteractionEnabled = true
        background.translatesAutoresizingMaskIntoConstraints = false
        
        let contentLabel = UILabel()
        contentLabel.text = "플로깅을 시작해 볼까요?"
        contentLabel.textColor = .black
        contentLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subLabel = UILabel()
        subLabel.text = "시작하시려면 빨간 재생 버튼을 눌러주세요."
        subLabel.textColor = .black
        subLabel.font = UIFont.systemFont(ofSize: 14)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("확인", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.setBackgroundImage(UIImage(named: "ploggingModalBtn"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(background)
        background.addSubview(contentLabel)
        background.addSubview(subLabel)
        background.addSubview(closeButton)
        NSLayoutConstraint.activate([
            // background의 크기와 중앙 정렬 설정
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            background.widthAnchor.constraint(equalToConstant: 300), // 팝업의 너비
            background.heightAnchor.constraint(equalToConstant: 200), // 팝업의 높이
            
            // 기타 제약 조건들
            contentLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: -30),
            
            subLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            
            closeButton.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: 60),
        ])
    }
    
    @objc func closeModal() {
        onConfirm?()
        dismiss(animated: true, completion: nil)
    }
}
