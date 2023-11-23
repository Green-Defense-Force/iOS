//
//  MapViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/16/23.
//

import UIKit
import Combine

class MapViewController: UIViewController, JoystickDelegate {
    
    var gameViewController: GameViewController!
    var joystickView: JoystickView!
    var viewModel = MapViewModel()
    var subscriptions = Set<AnyCancellable>()
    var monsterImageViews: [String: UIImageView] = [:]
    var front: UIImageView!
    var back: UIImageView!
    var upWalk1: UIImageView!
    var upWalk2: UIImageView!
    var right1: UIImageView!
    var right2: UIImageView!
    var downWalk1: UIImageView!
    var downWalk2: UIImageView!
    var left1: UIImageView!
    var left2: UIImageView!
    var field: UIImageView!
    var dropCoins: [UIImageView] = []
    
    lazy var ticketLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var userNameBox: UIView = {
        let userNameBox = UIView()
        userNameBox.backgroundColor = .white
        userNameBox.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        userNameBox.layer.borderWidth = 5
        userNameBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameBox)
        return userNameBox
    }()
    
    lazy var userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .black
        userName.translatesAutoresizingMaskIntoConstraints = false
        userNameBox.addSubview(userName)
        userName.centerXAnchor.constraint(equalTo: userNameBox.centerXAnchor).isActive = true
        userName.centerYAnchor.constraint(equalTo: userNameBox.centerYAnchor).isActive = true
        userName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return userName
    }()
    
    lazy var userLevel: UILabel = {
        let userLevel = UILabel()
        userLevel.textColor = .black
        userNameBox.addSubview(userLevel)
        userLevel.translatesAutoresizingMaskIntoConstraints = false
        userLevel.topAnchor.constraint(equalTo: userName.topAnchor).isActive = true
        userLevel.trailingAnchor.constraint(equalTo: userName.leadingAnchor, constant: -10).isActive = true
        return userLevel
    }()
    
    private var shouldShowRight1Flag = false
    private var shouldShowLeft1Flag = false
    private var shouldShowUp1Flag = false
    private var shouldShowDown1Flag = false
    private var shouldShowDefaultFlage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        viewModel.fetch()
        setupSwipeGesture()
    }
    
    func setUI() {
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        
        // 필드
        field = UIImageView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.contentMode = .scaleAspectFill
        view.addSubview(field)
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            field.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)
        ])
        
        
        // 조이스틱 유저 캐릭터
        front = UIImageView()
        front.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(front)
        
        // 조이스틱 움직임
        joystickView = JoystickView(frame: CGRect(x: 50, y: 200, width: 150, height: 150))
        joystickView.delegate = self
        joystickView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(joystickView)
        
        NSLayoutConstraint.activate([
            joystickView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            joystickView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            joystickView.widthAnchor.constraint(equalToConstant: 150), // 적절한 크기로 설정
            joystickView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // 캐릭터
        NSLayoutConstraint.activate([
            front.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            front.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            front.widthAnchor.constraint(equalToConstant: 35),
            front.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        back = UIImageView()
        view.addSubview(back)
        
        right1 = UIImageView()
        view.addSubview(right1)
        
        right2 = UIImageView()
        view.addSubview(right2)
        
        downWalk1 = UIImageView()
        view.addSubview(downWalk1)
        
        downWalk2 = UIImageView()
        view.addSubview(downWalk2)
        
        left1 = UIImageView()
        view.addSubview(left1)
        
        left2 = UIImageView()
        view.addSubview(left2)
        
        upWalk1 = UIImageView()
        view.addSubview(upWalk1)
        
        upWalk2 = UIImageView()
        view.addSubview(upWalk2)
        
        setCharacterImage(image: back, referenceImageView: front)
        setCharacterImage(image: upWalk1, referenceImageView: front)
        setCharacterImage(image: upWalk2, referenceImageView: front)
        setCharacterImage(image: right1, referenceImageView: front)
        setCharacterImage(image: right2, referenceImageView: front)
        setCharacterImage(image: downWalk1, referenceImageView: front)
        setCharacterImage(image: downWalk2, referenceImageView: front)
        setCharacterImage(image: left1, referenceImageView: front)
        setCharacterImage(image: left2, referenceImageView: front)
        
        let ticket = UIImageView(image: UIImage(named: "pointTicket"))
        ticket.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticket)
        NSLayoutConstraint.activate([
            ticket.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            ticket.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            ticket.widthAnchor.constraint(equalToConstant: 50),
            ticket.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        ticketLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticketLabel)
        NSLayoutConstraint.activate([
            ticketLabel.topAnchor.constraint(equalTo: ticket.topAnchor),
            ticketLabel.leadingAnchor.constraint(equalTo: ticket.trailingAnchor, constant: 5),
        ])
        
        let coin = UIImageView(image: UIImage(named: "coin"))
        coin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coin)
        NSLayoutConstraint.activate([
            coin.topAnchor.constraint(equalTo: ticket.topAnchor),
            coin.leadingAnchor.constraint(equalTo: ticketLabel.trailingAnchor, constant: 5),
            coin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            coin.widthAnchor.constraint(equalTo: ticket.widthAnchor, multiplier: 1),
            coin.heightAnchor.constraint(equalTo: ticket.heightAnchor, multiplier: 1)
        ])
        
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coinLabel)
        NSLayoutConstraint.activate([
            coinLabel.topAnchor.constraint(equalTo: coin.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coin.trailingAnchor, constant: 5),
        ])
        
        let dropCoin = UIImageView(image: UIImage(named: "coin"))
        dropCoin.translatesAutoresizingMaskIntoConstraints = false
        let randomTop = CGFloat.random(in: 0...(view.bounds.height - 150))
        let randomLeading = CGFloat.random(in: 0...(view.bounds.width - 150))
        view.addSubview(dropCoin)
        NSLayoutConstraint.activate([
            dropCoin.widthAnchor.constraint(equalToConstant: 20),
            dropCoin.heightAnchor.constraint(equalToConstant: 20),
            dropCoin.topAnchor.constraint(equalTo: view.topAnchor, constant: randomTop),
            dropCoin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: randomLeading)
        ])
       dropCoins.append(dropCoin)
        
    }
    
    func bind() {
        viewModel.$mapModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] mapModels in
                if !mapModels.isEmpty && self!.monsterImageViews.isEmpty {
                    guard let self = self else { return }
                    guard let mapModel = mapModels.first else { return }
                    self.viewModel.mapModels = mapModels
                    
                    let characterImageViews = [self.front, self.back, self.upWalk1, self.upWalk2, self.right1, self.right2, self.downWalk1, self.downWalk2, self.left1, self.left2]
                    
                    for (index, characterImageStr) in mapModel.character.enumerated() {
                        if let data = Data(base64Encoded: characterImageStr),
                           let characterImage = UIImage(data: data) {
                            characterImageViews[index]?.image = characterImage
                        }
                    }
                    
                    if let data = Data(base64Encoded: mapModel.field),
                       let fieldImage = UIImage(data: data) {
                        self.field.image = fieldImage
                    }
                    
                    self.ticketLabel.text = String(mapModel.ticketNum)
                    self.coinLabel.text = String(mapModel.coinNum)
                    self.userName.text = mapModel.userName
                    self.userLevel.text = String(mapModel.userLevel)
                    
                    self.setMonster()
                }
            }
            .store(in: &subscriptions)
    }
    
    func setCharacterImage(image: UIImageView, referenceImageView: UIImageView) {
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: front.topAnchor),
            image.widthAnchor.constraint(equalTo: front.widthAnchor),
            image.heightAnchor.constraint(equalTo: front.heightAnchor),
            image.leadingAnchor.constraint(equalTo: front.leadingAnchor),
        ])
    }
    
    func setMonster() {
        
        guard let mapModel = viewModel.mapModels.first else {
            print("mapModel is nil")
            return
        }
        
        let randomTop = CGFloat.random(in: 0...(view.bounds.height - 150))
        let randomLeading = CGFloat.random(in: 0...(view.bounds.width - 150))
        
        
        for monster in mapModel.mapMonsters {
            if let data = Data(base64Encoded: monster.monsterImage),
               let monsterImage = UIImage(data: data) {
                let monsterImageView = UIImageView(image: monsterImage)
                monsterImageView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(monsterImageView)
                NSLayoutConstraint.activate([
                    monsterImageView.widthAnchor.constraint(equalToConstant: 50),
                    monsterImageView.heightAnchor.constraint(equalToConstant: 50),
                    monsterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: randomTop),
                    monsterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: randomLeading)
                ])
                monsterImageViews[monster.monsterId] = monsterImageView
            }
        }
    }
    
    func joystickMoved(x: CGFloat, y: CGFloat) {
        // 여기에서 캐릭터를 이동하거나 필요한 작업을 수행합니다.
        let speed: CGFloat = 5
        let dx = speed * x
        let dy = speed * y
        
        // 뷰의 범위를 제한
        let newX = front.center.x + dx
        let newY = front.center.y + dy
        let maxX = view.bounds.width - front.bounds.width / 2
        let maxY = view.bounds.height - front.bounds.height / 2
        let minX = front.bounds.width / 2
        let minY = front.bounds.height / 2
        
        // 캐릭터 뷰의 새로운 중심 좌표를 설정
        front.center = CGPoint(x: min(maxX, max(minX, newX)),
                               y: min(maxY, max(minY, newY)))
        
        let imageViews = [left1, left2, upWalk1, upWalk2, right1, right2, downWalk1, downWalk2, back, front]
        imageViews.forEach { $0?.center = front.center}
        imageViews.forEach { $0?.alpha = 0 }
        
        // 조이스틱의 방향에 따라 적절한 이미지뷰를 표시
        func updateAlphaWithToggle(flag: inout Bool, imageView1: UIImageView, imageView2: UIImageView) {
            flag.toggle()
            imageView1.alpha = flag ? 1 : 0
            imageView2.alpha = flag ? 0 : 1
        }
        
        if x > 0 && y < 0 {
            // 조이스틱이 오른쪽으로 갈 때
            updateAlphaWithToggle(flag: &shouldShowRight1Flag, imageView1: right1, imageView2: right2)
        }
        
        if x < 0 && y > 0 {
            // 조이스틱이 왼쪽으로 갈 때
            updateAlphaWithToggle(flag: &shouldShowLeft1Flag, imageView1: left1, imageView2: left2)
        }
        
        if x > 0 && y >= 0 {
            // 조이스틱이 아래로 갈 때
            updateAlphaWithToggle(flag: &shouldShowDown1Flag, imageView1: downWalk1, imageView2: downWalk2)
        }
        
        if x <= 0 && y < 0 {
            // 조이스틱이 위로 갈 때
            updateAlphaWithToggle(flag: &shouldShowUp1Flag, imageView1: upWalk1, imageView2: upWalk2)
        }
        
        if x == 0 && y == 0 {
            back.alpha = 1
        }
        getDropCoin()
    }
    
    func joystickReleased() {
        // 현재 캐릭터 이미지뷰의 프레임과 교차하는 몬스터 이미지뷰를 찾음
        if let intersectedMonsterId = monsterImageViews.first(where: { front.frame.intersects($0.value.frame)})?.key{
            monsterImageViews[intersectedMonsterId]?.removeFromSuperview()
            monsterImageViews.removeValue(forKey: intersectedMonsterId)
            
            if let index = viewModel.mapModels.first?.mapMonsters.firstIndex(where: { $0.monsterId == intersectedMonsterId }) {
                var firstMapModel = viewModel.mapModels.first
                firstMapModel?.mapMonsters.remove(at: index)
                viewModel.mapModels[0] = firstMapModel!
            }

            gameViewController = GameViewController()
            navigationController?.pushViewController(gameViewController, animated: false)
        }
    }
    
    func getDropCoin() {
        if let coinNum = Int(coinLabel.text ?? "0") {
            for dropCoin in dropCoins {
                if front.frame.intersects(dropCoin.frame) {
                    dropCoin.removeFromSuperview()
                    coinLabel.text = "\(coinNum + 1)"
                    if let index = dropCoins.firstIndex(of: dropCoin) {
                        dropCoins.remove(at: index)
                    }
                    break
                }
            }
        }
    }
    
    func setupSwipeGesture() {
        let swipeGuesture = UISwipeGestureRecognizer(target: self, action: #selector(backTappedButton))
        // 왼쪽에서 오른쪽으로
        swipeGuesture.direction = .right
        view.addGestureRecognizer(swipeGuesture)
    }
    
    @objc func backTappedButton() {
        navigationController?.popViewController(animated: false)
    }
}


