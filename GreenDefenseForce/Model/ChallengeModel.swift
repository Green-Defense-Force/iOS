//
//  ChallengeModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/29/23.
//

import Foundation

struct ChallengeModel {
    var userId: String
    var challengePreviews: [ChallengePreview]
}

struct ChallengePreview {
    var challengeId: String
    var challengeTitle: String
    var rewardType: String
    var rewardCount: Int
    var isDone: Bool
}

