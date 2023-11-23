//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.


import UIKit
import Combine

class GameViewController: UIViewController, PopUpDelegate {
    
    var viewModel = GameViewModel()
    var subscriptions = Set<AnyCancellable>()
    var alterImage = false
    var field: UIImageView!
    var defaultCharacter: UIImageView!
    var attackCharacter: UIImageView!
    var monster: UIImageView!
    var effect: UIImageView!
    let defaultButton = UIImageView(image: UIImage(named: "button"))
    let buttonTap = UIImageView(image: UIImage(named: "buttonTap"))

    lazy var hpBar: UIProgressView = {
        let hpBar = UIProgressView()
        hpBar.translatesAutoresizingMaskIntoConstraints = false
        hpBar.progressTintColor = .red
        hpBar.progressViewStyle = .default
        hpBar.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        hpBar.layer.borderWidth = 5
        return hpBar
    }()
    lazy var monsterName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        hpBar.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.centerXAnchor.constraint(equalTo: hpBar.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: hpBar.topAnchor, constant: -5)
        ])
        return label
    }()
    lazy var monsterTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        hpBar.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: monsterName.topAnchor, constant: -30),
            label.centerXAnchor.constraint(equalTo: hpBar.centerXAnchor)
        ])
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        viewModel.fetch()
        setupSwipeGesture()
        attckMonsterTapBtn()
    }
    
    func setUI() {
        
        // NVTitle
        setNavigationBlackTitleWhiteBg(title: "")
        // NVLItem
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        
        field = UIImageView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.contentMode = .scaleAspectFill
        view.addSubview(field)
        NSLayoutConstraint.activate([
            field.topAnchor.constraint(equalTo: view.topAnchor),
            field.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            field.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            field.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
        
        // 유저 캐릭터
        defaultCharacter = UIImageView()
        defaultCharacter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(defaultCharacter)
        
        attackCharacter = UIImageView()
        attackCharacter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(attackCharacter)
        attackCharacter.alpha = 0.0
        NSLayoutConstraint.activate([
            defaultCharacter.widthAnchor.constraint(equalToConstant: 200),
            defaultCharacter.heightAnchor.constraint(equalToConstant: 200),
            defaultCharacter.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            defaultCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            attackCharacter.widthAnchor.constraint(equalTo: defaultCharacter.widthAnchor),
            attackCharacter.heightAnchor.constraint(equalTo: defaultCharacter.heightAnchor),
            attackCharacter.bottomAnchor.constraint(equalTo: defaultCharacter.bottomAnchor),
            attackCharacter.leadingAnchor.constraint(equalTo: defaultCharacter.leadingAnchor)
            
        ])
        
        // 몬스터
        monster = UIImageView()
        monster.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(monster)
        NSLayoutConstraint.activate([
            monster.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            monster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            monster.widthAnchor.constraint(equalToConstant: 200),
            monster.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        // Hp
        view.addSubview(hpBar)
        NSLayoutConstraint.activate([
            hpBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hpBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            hpBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            hpBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 버튼 기본상태
        
        defaultButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(defaultButton)
        NSLayoutConstraint.activate([
            defaultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            defaultButton.bottomAnchor.constraint(equalTo: defaultCharacter.bottomAnchor),
            defaultButton.widthAnchor.constraint(equalToConstant: 100),
            defaultButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // 눌린 버튼
        buttonTap.alpha = 0
        buttonTap.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonTap)
        NSLayoutConstraint.activate([
            buttonTap.topAnchor.constraint(equalTo: defaultButton.topAnchor),
            buttonTap.trailingAnchor.constraint(equalTo: defaultButton.trailingAnchor),
            buttonTap.bottomAnchor.constraint(equalTo: defaultButton.bottomAnchor),
            buttonTap.widthAnchor.constraint(equalTo: defaultButton.widthAnchor),
            buttonTap.heightAnchor.constraint(equalTo: defaultButton.heightAnchor)
        ])
        
        effect = UIImageView()
        effect.alpha = 0
        effect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(effect)
        NSLayoutConstraint.activate([
            effect.topAnchor.constraint(equalTo: monster.topAnchor),
            effect.bottomAnchor.constraint(equalTo: monster.bottomAnchor),
            effect.trailingAnchor.constraint(equalTo: monster.trailingAnchor),
            effect.widthAnchor.constraint(equalTo: monster.widthAnchor, multiplier: 1),
            effect.heightAnchor.constraint(equalTo: monster.heightAnchor, multiplier: 1)
            
        ])
    }
    
    func bind() {
        viewModel.$gameModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gameModels in
                guard let model = gameModels.first else {
                    return
                }
                if !gameModels.isEmpty {
                    
                    if let imageData = Data(base64Encoded: model.battleField),
                       let image = UIImage(data: imageData) {
                        self?.field.image = image
                    }
                    
                    if let imageData = Data(base64Encoded: model.attackImages[0]),
                       let image = UIImage(data: imageData) {
                        self?.defaultCharacter.image = image
                    }
                    
                    if let imageData = Data(base64Encoded: model.attackImages[1]),
                       let image = UIImage(data: imageData) {
                        self?.attackCharacter.image = image
                    }
                    
                    if let imageData = Data(base64Encoded: model.monsterImage),
                       let image = UIImage(data: imageData) {
                        self?.monster.image = image
                    }
                    
                    if let imageData = Data(base64Encoded: model.attackEffect),
                       let image = UIImage(data: imageData) {
                        self?.effect.image = image
                    }
                    self?.hpBar.progress = Float(model.monsterHp)
                    self?.monsterName.text = model.monsterName
                    self?.monsterTitle.text = model.monsterTitle
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
    
    func attckMonsterTapBtn() {
        let attackTap = UITapGestureRecognizer(target: self, action: #selector(attackTap))
        defaultButton.isUserInteractionEnabled = true
        defaultButton.addGestureRecognizer(attackTap)
    }
    
    @objc func attackTap() {
        alterImage.toggle()
        
        UIView.animate(withDuration:0, animations:  {
            self.defaultCharacter.alpha = self.alterImage ? 0.0 : 1.0
            self.attackCharacter.alpha = self.alterImage ? 1.0 : 0.0
            self.defaultButton.alpha = self.alterImage ? 0.0 : 1.0
            self.buttonTap.alpha = self.alterImage ? 1.0 : 0.0
            self.effect.alpha = self.alterImage ? 1.0 : 0.0
        }) {_ in
            self.defaultCharacter.alpha = 1
            self.attackCharacter.alpha = 0
            self.effect.alpha = 0
            self.defaultButton.alpha = 1
            self.buttonTap.alpha = 0
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
        
        if currentProgress == 0 {
            showPopUp()
        }
    }
    
    func returnToMap() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func backTappedButton() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func showPopUp() {
        let popUpViewController = PopUp()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.delegate = self
        present(popUpViewController, animated: true, completion: nil)
    }
}
