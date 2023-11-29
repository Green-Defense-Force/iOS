//
//  HomeVM.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import UIKit
import Combine

class MapViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    private let networkService = NetworkService(configuration: .default)
    
    @Published var mapModels: [MapModel] = []
    
    func fetch() {
        let mapModelURLs = [
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
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/field1.png?raw=true", // 필드 맵
        ]
        
        mapModelURLs.publisher
            .flatMap(maxPublishers: .max(1)) { url in
                self.networkService.imageFetch(url: url) { (data:Data) -> String? in
                    return data.base64EncodedString()
                }
            }
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("mapVM finished")
                case .failure(let error):
                    print("mapVM error:\(error)")
                }
            }, receiveValue: { [weak self] strings in
                
                guard let monsterImage = strings.first,
                      let fieldImage = strings.last else { return }
                let frontImage = strings[1]
                let backImage = strings[2]
                let up1Image = strings[3]
                let up2Image = strings[4]
                let right1Image = strings[5]
                let right2Image = strings[6]
                let down1Image = strings[7]
                let down2Image = strings[8]
                let left1Image = strings[9]
                let left2Image = strings[10]
                
                let characterImages = [frontImage, backImage, up1Image, up2Image, right1Image, right2Image, down1Image, down2Image, left1Image, left2Image]
                
                let monsterPreview = MonsterPreview(monsterId: "0", monsterImage: monsterImage)
                
                self?.mapModels = [MapModel(ticketNum: 3, coinNum: 5, mapMonsters: [monsterPreview], character: characterImages, userName: "", userLevel: 0, field: fieldImage)]
            })
            .store(in: &subscriptions)
    }
}
