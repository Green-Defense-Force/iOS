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
    var viewModel = GameViewModel()
    var subscriptions = Set<AnyCancellable>()
    var mapModel: MapModel = MapModel(ticketNum: 3, coinNum: 5, mapMonsters: [], character: [], userName: "꼼꼼재", userLevel: 1)
    var imageView: [UIImageView] = []
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
    var ticket: UIImageView!
    var coin: UIImageView!
    lazy var ticketLabel: UILabel = {
        let label = UILabel()
        var ticketNum = mapModel.ticketNum
        label.text = String(ticketNum)
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var coinLabel: UILabel = {
        let label = UILabel()
        var coinNum = mapModel.coinNum
        label.text = String(coinNum)
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    lazy var userName: UIView = {
       let userNameBox = UIView()
        userNameBox.backgroundColor = .white
        userNameBox.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        userNameBox.layer.borderWidth = 5
        userNameBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameBox)
        
        let userName = UILabel()
        userName.textColor = .black
        userName.text = mapModel.userName
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.centerXAnchor.constraint(equalTo: userNameBox.centerXAnchor).isActive = true
        userName.centerYAnchor.constraint(equalTo: userNameBox.centerYAnchor).isActive = true
        userNameBox.addSubview(userName)
        
        let userLevel = UILabel()
        userLevel.textColor = .black
        userLevel.text = mapModel.userName
        userLevel.translatesAutoresizingMaskIntoConstraints = false
        userLevel.topAnchor.constraint(equalTo: userName.topAnchor).isActive = true
        userLevel.trailingAnchor.constraint(equalTo: userName.leadingAnchor, constant: -10).isActive = true
        userNameBox.addSubview(userLevel)
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: front.bottomAnchor, constant: 10),
            userName.widthAnchor.constraint(equalToConstant: 70),
            userName.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return userNameBox
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
        viewModel.fieldFetchImage()
        setupSwipeGesture()
        view.backgroundColor = UIColor(red: 0.49, green: 0.67, blue: 0.25, alpha: 1.0)
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

        ticket = UIImageView()
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
        
        coin = UIImageView()
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
        
        setMonster()
    }
    
    func bind() {
        viewModel.$fieldImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                for (index, image) in images.enumerated() {
                    switch index {
                    case 0:
                        self?.mapModel.mapMonsters.forEach { $0.image = image }
                    case 1:
                        self?.front.image = image
                    case 2:
                        self?.back.image = image
                    case 3:
                        self?.upWalk1.image = image
                    case 4:
                        self?.upWalk2.image = image
                    case 5:
                        self?.right1.image = image
                    case 6:
                        self?.right2.image = image
                    case 7:
                        self?.downWalk1.image = image
                    case 8:
                        self?.downWalk2.image = image
                    case 9:
                        self?.left1.image = image
                    case 10:
                        self?.left2.image = image
                    case 11:
                        self?.ticket.image = image
                    case 12:
                        self?.field.image = image
                    case 13:
                        self?.coin.image = image
                    default:
                        break
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    func setCharacterImage(image: UIImageView, referenceImageView: UIImageView) {
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: referenceImageView.topAnchor),
            image.widthAnchor.constraint(equalTo: referenceImageView.widthAnchor),
            image.heightAnchor.constraint(equalTo: referenceImageView.heightAnchor),
            image.leadingAnchor.constraint(equalTo: referenceImageView.leadingAnchor),
        ])
    }
    
    func setMonster() {
        let monsterCount = 5 // 원하는 몬스터 수

        for _ in 1...monsterCount {
            let mapMonster = UIImageView()
            mapMonster.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(mapMonster)

            let randomTop = CGFloat.random(in: 0...(view.bounds.height - 50))
            let randomLeading = CGFloat.random(in: 0...(view.bounds.width - 50))

            NSLayoutConstraint.activate([
                mapMonster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: randomLeading),
                mapMonster.topAnchor.constraint(equalTo: view.topAnchor, constant: randomTop),
                mapMonster.widthAnchor.constraint(equalToConstant: 50),
                mapMonster.heightAnchor.constraint(equalToConstant: 50)
            ])

            mapModel.mapMonsters.append(mapMonster)
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
    }
    
    func joystickReleased() {
        // 현재 캐릭터 이미지뷰의 프레임과 교차하는 몬스터 이미지뷰를 찾음
        if let intersectedMonster = mapModel.mapMonsters.first(where: { front.frame.intersects($0.frame) }) {
            // 찾은 몬스터 이미지뷰를 배열에서 제거하고 화면에서 제거
            if let index = mapModel.mapMonsters.firstIndex(of: intersectedMonster) {
                mapModel.mapMonsters.remove(at: index)
                intersectedMonster.removeFromSuperview()
            }
            
            // 여기에서 캐릭터 움직임이 멈췄을 때 필요한 작업을 수행합니다.
            // 예: 게임 뷰 컨트롤러를 푸시
            gameViewController = GameViewController()
            navigationController?.pushViewController(gameViewController, animated: true)
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

