//
//  ChallengeTableViewCell.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/2/23.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ChallengeCell"
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
    
    func setUI() {
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel?.textAlignment = .center
        textLabel?.layer.borderColor = UIColor.black.cgColor
        textLabel?.layer.borderWidth = 5
        textLabel?.backgroundColor = .white
        backgroundColor = UIColor(red: 82/255, green: 133/255, blue: 31/255, alpha: 1.0)
        selectionStyle = .none
    }
    
    func configure(challengePreview: ChallengePreview) {
        textLabel?.text = "\(challengePreview.rewardType)x\(challengePreview.rewardCount): \(challengePreview.challengeTitle)"
        
        func configure(challengePreview: ChallengePreview) {
               textLabel?.text = "\(challengePreview.rewardType)x\(challengePreview.rewardCount): \(challengePreview.challengeTitle)"
               
            // 챌린지 진행여부가 false에서 true로 변경시!
            // 근데 이 부분은 아직 서버가 연결되서 확인할 수 있는 것이 아니라 추후 서버와 연결 후 영구적인 변경으로 되는지 봐야함.
               if challengePreview.isDone == true {
                   textLabel?.text = "진행 중"
                   textLabel?.textColor = .white
                   textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                   textLabel?.backgroundColor = .black.withAlphaComponent(0.6)
                   // 테두리를 없애거나 조절하려면 아래 두 줄을 사용하세요.
                   textLabel?.layer.borderWidth = 0
                   textLabel?.layer.borderColor = UIColor.clear.cgColor
               }
           }
    }
}
