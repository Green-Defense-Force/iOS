//
//  HomeVM.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import UIKit
import Combine

class GameViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    private let imageFetcher = ImageFetch(configuration: .default)
    var isAlterImage = false
    
    @Published var fieldImage: [UIImage] = []
    @Published var battleImage: [UIImage] = []
    
    func fieldFetchImage() {
        let fieldImageURLs = [
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/monster1.png?raw=true", // 필드 몬스터
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/front.png?raw=true", // 앞
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/back.png?raw=true",  // 뒤
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/up1.png?raw=true", // 위로 걷기1
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/up2.png?raw=true", // 위로 걷기2
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/right1.png?raw=true", // 오른쪽으로 걷기1
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/right2.png?raw=true", // 오른쪽으로 걷기2
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/down1.png?raw=true", // 아래로 걷기1
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/down2.png?raw=true", // 아래로 걷기2
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/left1.png?raw=true", // 왼쪽으로 걷기1
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/left2.png?raw=true", // 왼쪽으로 걷기2
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/pointTicket.png?raw=true", // 티켓
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/field1.png?raw=true", // 필드 맵
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/coin.png?raw=true" // 코인
        ]
        
        let publishers = fieldImageURLs.enumerated().map { (index, url) in
            imageFetcher.imageFetch(url: url)
                .map { ImageInfo(index: index, image: $0)}
        }
        Publishers.MergeMany(publishers)
            .collect()
            .map { $0.sorted(by: { $0.index < $1.index }).map { $0.image } }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error:\(error)")
                }
            }, receiveValue: { image in
                self.fieldImage = image
                print(image)
            })
            .store(in: &subscriptions)
    }
    
    func battleFetchImage() {
        let battleImageURLs = [
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battlefield1.jpg?raw=true", // 배틀 필드
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battleCharacter1.png?raw=true",// 캐릭터 공격 전
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/battleCharacter2.png?raw=true", // 캐릭터 공격
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/monster1.png?raw=true", // 몬스터
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/Effect1.png?raw=true", // 이펙트
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/button.png?raw=true", // 버튼 눌리기 전
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/buttonTap.png?raw=true", // 눌린 버튼
        ]
        let publishers = battleImageURLs.enumerated().map { (index, url) in
            imageFetcher.imageFetch(url: url)
                .map {ImageInfo(index: index, image: $0)}
        }
        Publishers.MergeMany(publishers)
            .collect()
            .map { $0.sorted(by: { $0.index < $1.index }).map { $0.image } }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error:\(error)")
                }
            }, receiveValue: { image in
                self.battleImage = image
                print(image)
            })
            .store(in: &subscriptions)
    }
}
