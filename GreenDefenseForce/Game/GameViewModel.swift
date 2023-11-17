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
    
    @Published var image: [UIImage] = []
    
    func fetchImage() {
        let imageURLs = [
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/monster1%20(2).png?raw=true", // 몬스터
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
        ]
        
        let publishers = imageURLs.enumerated().map { (index, url) in
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
                self.image = image
                print(image)
            })
            .store(in: &subscriptions)
    }
}
