//
//  ChallengeDetailViewModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/3/23.
//

import Foundation

class ChallengeDetailViewModel {
    var challengeDetailModel: ChallengeDetailModel?
    
    func fetch() {
        challengeDetailModel = ChallengeDetailModel(
            challengeId: "1",
            challengeTitle: "페트병 분리 배출하기",
            challengeContent: "[하루 1회] \n 한 개의 패트병을 재활용하면 \n 약 142g의 탄소배출을 줄일 수 있어요.",
            challengeGoal: "올바른 분리 배출로 우리의 환경을 지켜보아요!",
            challengeCorrectExample: "올바른 사진",
            challengeWrongExample: "틀린 사진",
            challengeChecklist: "내용물이 비었나요? \n페트병 안을 잘 행궜나요? \n분리 배출한 것이 잘 보이나요? ",
            rewardType: "티켓",
            rewardCount: 1
        )
    }
}


