//
//  ChallengeDetail.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/29/23.
//

import Foundation

struct ChallengeDetailModel: Codable, Hashable {
    var challengeId: String
    var challengeTitle: String
    var challengeContent: String
    var challengeGoal: String
    var challengeCorrectExample: String
    var challengeWrongExample: String
    var challengeChecklist: String
    var rewardType: String
    var rewardCount: Int
}
