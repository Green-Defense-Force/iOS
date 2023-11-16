//
//  JoyStickViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/16/23.
//

import UIKit

class JoyStickViewController: UIViewController, JoystickDelegate {

    var characterImageView: UIImageView!
    var joystickView: JoystickView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        characterImageView = UIImageView(image: UIImage(systemName: "figure.walk"))
        characterImageView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        view.addSubview(characterImageView)

        joystickView = JoystickView(frame: CGRect(x: 50, y: 200, width: 150, height: 150))
        joystickView.delegate = self
        view.addSubview(joystickView)
    }

    // 추가: Joystick 델리게이트 메서드 구현
    func joystickMoved(x: CGFloat, y: CGFloat) {
        // 여기에서 캐릭터를 이동하거나 필요한 작업을 수행합니다.
        let speed: CGFloat = 5.0
        let dx = speed * x
        let dy = speed * y
        characterImageView.center = CGPoint(x: characterImageView.center.x + dx, y: characterImageView.center.y + dy)
    }

    func joystickReleased() {
        // 여기에서 캐릭터 움직임이 멈췄을 때 필요한 작업을 수행합니다.
    }
}
