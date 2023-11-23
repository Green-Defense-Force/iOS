//
//  GameViewModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/22/23.
//

import Foundation
import Combine

final class GameViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    private let networkService = NetworkService(configuration: .default)
    
    @Published var gameModels: [GameModel] = []
    
    func fetch() {
        let gameModelURLs = [
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battlefield1.jpg?raw=true", // 배틀 필드
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battleCharacter1.png?raw=true",// 캐릭터 공격 전
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battleCharacter2.png?raw=true", // 캐릭터 공격
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/monster1.png?raw=true", // 몬스터
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/Effect1.png?raw=true", // 이펙트
        ]
        
        gameModelURLs.publisher
            .flatMap(maxPublishers: .max(1)) { url in
                self.networkService.imageFetch(url: url) { (data:Data) -> String? in
                    return data.base64EncodedString()
                }
            }
            .collect()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("gameVM finished")
                case .failure(let error):
                    print("gameVM error: \(error)")
                }
            } receiveValue: { [weak self] strings in

                let battleField = strings[0]
                let characterImageBeforeAttack = strings[1]
                let characterImageDuringAttack = strings[2]
                let monsterImage = strings[3]
                let effectImage = strings[4]
                
                let attackImages = [characterImageBeforeAttack, characterImageDuringAttack]
                print("여기:",battleField, characterImageBeforeAttack, characterImageDuringAttack, monsterImage, effectImage)
                self?.gameModels = [GameModel(userId: "0", attackImages: attackImages, attackEffect: effectImage, monsterId: "0", monsterTitle: "한강의", monsterName: "쓰레기 봉지", monsterImage: monsterImage, monsterHp: 100, battleField: battleField)]
            }
            .store(in: &subscriptions)
    }
}

