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
    
    // Output
    @Published var image: UIImage?
    
    func fetchImage() {
        imageFetcher.imageFetch(url: "https://i.pravatar.cc/")
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
