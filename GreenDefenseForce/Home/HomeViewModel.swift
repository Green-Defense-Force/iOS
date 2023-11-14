//
//  HomeVM.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import UIKit
import Combine

class HomeViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    private let imageFetcher = ImageFetch(configuration: .default)
    var isAlterImage = false
    @Published var image: [UIImage] = []
    
    func fetchImage() {
        
        let imageURLs = [
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/66px_5zu1_230310.jpg?raw=true",
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/New%20Piskel.png?raw=true",
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/monster1.png?raw=true",
            "https://github.com/leewanjae/imageAPI_Test/blob/main/image/New%20Piskel%20(2).png?raw=true",
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
            })
            .store(in: &subscriptions)
    }
}
