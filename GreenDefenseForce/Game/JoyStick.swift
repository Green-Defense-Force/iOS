//
//  JoyStick.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/16/23.
//

import UIKit

class JoystickView: UIView {
    
    private let stickView = UIView()
    private var joystickRadius: CGFloat = 0.0
    private var joystickImageView: UIImageView!
    weak var delegate: JoystickDelegate?

    var joystickImage: UIImage? {
            didSet {
                joystickImageView.image = joystickImage
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupJoystick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupJoystick()
    }
    
    private func setupJoystick() {
        // Joystick 배경
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        layer.cornerRadius = bounds.width / 2
        
        joystickRadius = bounds.width / 2
        
        // Stick 설정
        stickView.frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: bounds.height / 2)
        stickView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        stickView.backgroundColor = UIColor.blue
        stickView.layer.cornerRadius = stickView.bounds.width / 2
        addSubview(stickView)
        
        // Pan Gesture Recognizer 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        // Joystick의 중심에서 팬 제스처로 이동한 거리를 반지름으로 나누어 정규화
        let normalizedX = min(max(translation.x / joystickRadius, -1.0), 1.0)
        let normalizedY = min(max(translation.y / joystickRadius, -1.0), 1.0)
        
        // Stick을 이동
        stickView.transform = CGAffineTransform(translationX: normalizedX * (joystickRadius / 2), y: normalizedY * (joystickRadius / 2))
        
        // 추가: 델리게이트에게 움직임을 알림
        delegate?.joystickMoved(x: normalizedX, y: normalizedY)
        
        // 팬 제스처가 종료되면 Stick을 중앙으로 되돌리기
        if gesture.state == .ended {
            delegate?.joystickReleased()
            
            resetStick()
        }
    }
    
    private func resetStick() {
        UIView.animate(withDuration: 0.3) {
            self.stickView.transform = .identity
        }
    }
}

// 추가: Joystick 델리게이트
protocol JoystickDelegate: AnyObject {
    func joystickMoved(x: CGFloat, y: CGFloat)
    func joystickReleased()
}
