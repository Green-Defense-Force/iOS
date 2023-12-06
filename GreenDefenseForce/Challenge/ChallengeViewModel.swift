//
//  ChallengeModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/2/23.
//

import Foundation

class ChallengeViewModel {
    var challengeModel: ChallengeModel?
    
    var numberOfChallenges: Int {
        return challengeModel?.challengePreviews.count ?? 0
    }
    
    func challengePreview(index: Int) -> ChallengePreview? {
        return challengeModel?.challengePreviews[index]
    }
    
    func fetch() {
        let challengePreviews = [
            ChallengePreview(challengeId: "1", challengeTitle: "페트병 분리 배출하기", rewardType: "티켓", rewardCount: 1, isDone: false),
            ChallengePreview(challengeId: "2", challengeTitle: "카페에서 텀블러 사용하기", rewardType: "티켓", rewardCount: 1, isDone: false),
            ChallengePreview(challengeId: "3", challengeTitle: "카페 빨대 사용하지 않기", rewardType: "티켓", rewardCount: 1, isDone: false),
            ChallengePreview(challengeId: "4", challengeTitle: "(플로깅) 쓰레기 5개 줍기", rewardType: "코인", rewardCount: 10, isDone: false),
            ChallengePreview(challengeId: "5", challengeTitle: "대중교통(버스) 이용하기", rewardType: "티켓", rewardCount: 1, isDone: false),
            ChallengePreview(challengeId: "6", challengeTitle: "카카오톡 친구 초대하기", rewardType: "코인", rewardCount: 20, isDone: false),
        ]
        
        challengeModel = ChallengeModel(userId: "ggmj", challengePreviews: challengePreviews)
    }
}
