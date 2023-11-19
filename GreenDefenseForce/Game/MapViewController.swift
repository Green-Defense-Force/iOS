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
    var mapMonster: UIImageView!
    var field: UIImageView!
    var ticket: UIImageView!
    var viewModel = GameViewModel()
    var subscriptions = Set<AnyCancellable>()
    
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
        
        back = UIImageView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.alpha = 0
        view.addSubview(back)
        
        right1 = UIImageView()
        right1.translatesAutoresizingMaskIntoConstraints = false
        right1.alpha = 0
        view.addSubview(right1)
        
        right2 = UIImageView()
        right2.translatesAutoresizingMaskIntoConstraints = false
        right2.alpha = 0
        view.addSubview(right2)
        
        downWalk1 = UIImageView()
        downWalk1.translatesAutoresizingMaskIntoConstraints = false
        downWalk1.alpha = 0
        view.addSubview(downWalk1)
        
        downWalk2 = UIImageView()
        downWalk2.translatesAutoresizingMaskIntoConstraints = false
        downWalk2.alpha = 0
        view.addSubview(downWalk2)
        
        left1 = UIImageView()
        left1.translatesAutoresizingMaskIntoConstraints = false
        left1.alpha = 0
        view.addSubview(left1)
        
        left2 = UIImageView()
        left2.translatesAutoresizingMaskIntoConstraints = false
        left2.alpha = 0
        view.addSubview(left2)
        
        upWalk1 = UIImageView()
        upWalk1.translatesAutoresizingMaskIntoConstraints = false
        upWalk1.alpha = 0
        view.addSubview(upWalk1)
        
        upWalk2 = UIImageView()
        upWalk2.translatesAutoresizingMaskIntoConstraints = false
        upWalk2.alpha = 0
        view.addSubview(upWalk2)
        
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
            
            back.topAnchor.constraint(equalTo: front.topAnchor),
            back.widthAnchor.constraint(equalTo: front.widthAnchor),
            back.heightAnchor.constraint(equalTo: front.heightAnchor),
            back.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            upWalk1.topAnchor.constraint(equalTo: front.topAnchor),
            upWalk1.widthAnchor.constraint(equalTo: front.widthAnchor),
            upWalk1.heightAnchor.constraint(equalTo: front.heightAnchor),
            upWalk1.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            upWalk2.topAnchor.constraint(equalTo: front.topAnchor),
            upWalk2.widthAnchor.constraint(equalTo: front.widthAnchor),
            upWalk2.heightAnchor.constraint(equalTo: front.heightAnchor),
            upWalk2.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            right1.topAnchor.constraint(equalTo: front.topAnchor),
            right1.widthAnchor.constraint(equalTo: front.widthAnchor),
            right1.heightAnchor.constraint(equalTo: front.heightAnchor),
            right1.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            right2.topAnchor.constraint(equalTo: front.topAnchor),
            right2.widthAnchor.constraint(equalTo: front.widthAnchor),
            right2.heightAnchor.constraint(equalTo: front.heightAnchor),
            right2.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            downWalk1.topAnchor.constraint(equalTo: front.topAnchor),
            downWalk1.widthAnchor.constraint(equalTo: front.widthAnchor),
            downWalk1.heightAnchor.constraint(equalTo: front.heightAnchor),
            downWalk1.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            downWalk2.topAnchor.constraint(equalTo: front.topAnchor),
            downWalk2.widthAnchor.constraint(equalTo: front.widthAnchor),
            downWalk2.heightAnchor.constraint(equalTo: front.heightAnchor),
            downWalk2.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            left1.topAnchor.constraint(equalTo: front.topAnchor),
            left1.widthAnchor.constraint(equalTo: front.widthAnchor),
            left1.heightAnchor.constraint(equalTo: front.heightAnchor),
            left1.leadingAnchor.constraint(equalTo: front.leadingAnchor),
            
            left2.topAnchor.constraint(equalTo: front.topAnchor),
            left2.widthAnchor.constraint(equalTo: front.widthAnchor),
            left2.heightAnchor.constraint(equalTo: front.heightAnchor),
            left2.leadingAnchor.constraint(equalTo: front.leadingAnchor),
        ])
        
        // 몬스터
        mapMonster = UIImageView()
        mapMonster.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapMonster)
        
        NSLayoutConstraint.activate([
            mapMonster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapMonster.topAnchor.constraint(equalTo: front.topAnchor),
            mapMonster.widthAnchor.constraint(equalToConstant: 50),
            mapMonster.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        ticket = UIImageView()
        ticket.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticket)
        NSLayoutConstraint.activate([
            ticket.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            ticket.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ticket.widthAnchor.constraint(equalToConstant: 50),
            ticket.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    func bind() {
        viewModel.$fieldImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                for (index, image) in images.enumerated() {
                    switch index {
                    case 0:
                        self?.mapMonster.image = image
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
                    default:
                        break
                    }
                }
            }
            .store(in: &subscriptions)
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
        if x > 0 && y < 0{
            // 조이스틱이 오른쪽으로 갈 때
            shouldShowRight1Flag.toggle()
            right1.alpha = shouldShowRight1Flag ? 1 : 0
            right2.alpha = shouldShowRight1Flag ? 0 : 1
            
        }
        
        if x < 0 && y > 0 {
            // 조이스틱이 왼쪽으로 갈 때
            shouldShowLeft1Flag.toggle()
            left1.alpha = shouldShowLeft1Flag ? 1 : 0
            left2.alpha = shouldShowLeft1Flag ? 0 : 1
            
        }
        
        if x > 0 && y >= 0 {
            // 조이스틱이 아래로 갈 때
            shouldShowDown1Flag.toggle()
            downWalk1.alpha = shouldShowDown1Flag ? 1 : 0
            downWalk2.alpha = shouldShowDown1Flag ? 0 : 1
            
        }
        
        if x <= 0 && y < 0 {
            // 조이스틱이 위로 갈 때
            shouldShowUp1Flag.toggle()
            upWalk1.alpha = shouldShowUp1Flag ? 1 : 0
            upWalk2.alpha = shouldShowUp1Flag ? 0 : 1
        }
        
        if x == 0 && y == 0 {
            back.alpha = 1
        }
    }
    
    func joystickReleased() {
        // 여기에서 캐릭터 움직임이 멈췄을 때 필요한 작업을 수행합니다.
        if front.frame.intersects(mapMonster.frame) {
            // 이미지뷰가 만났을 때 수행할 액션
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
        navigationController?.popViewController(animated: true)
    }
}

