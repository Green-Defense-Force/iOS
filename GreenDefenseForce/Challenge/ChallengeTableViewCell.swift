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
    }
}
