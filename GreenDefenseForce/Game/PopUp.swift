//
//  PopUp.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/19/23.
//

import UIKit

protocol PopUpDelegate: AnyObject {
    func returnToMap()
}

final class PopUp: UIViewController {
    weak var delegate: PopUpDelegate?
    
    lazy var popUp: UIView = {
        let popUp = UIView()
        popUp.backgroundColor = .white
        popUp.layer.cornerRadius = 10
        popUp.layer.borderWidth = 5
        popUp.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        popUp.translatesAutoresizingMaskIntoConstraints = false
        return popUp
    }()
    
    lazy var textContent: UILabel = {
       let label = UILabel()
        label.text = "내용"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("돌아가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 5
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(popUp)
        NSLayoutConstraint.activate([
            popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUp.widthAnchor.constraint(equalToConstant: 300),
            popUp.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        popUp.addSubview(textContent)
        NSLayoutConstraint.activate([
            textContent.topAnchor.constraint(equalTo: popUp.topAnchor, constant: 20),
            textContent.centerXAnchor.constraint(equalTo: popUp.centerXAnchor)
        ])
        
        popUp.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: popUp.bottomAnchor),
            closeButton.centerXAnchor.constraint(equalTo: popUp.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.returnToMap()
        }
    }
}
