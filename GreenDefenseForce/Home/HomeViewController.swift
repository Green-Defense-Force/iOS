//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var imageView: UIImageView!
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBlackTitleWhiteBg(title: "게임")
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)

        if let imageURL = URL(string: "https://i.pravatar.cc/") {
            cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
                .map { UIImage(data: $0.data)}
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let err) = completion {
                        print("Retrieval failed: \(err)")
                    }
                }, receiveValue: { [weak self] image in
                    if let image = image {
                        self?.imageView.image = image
                    } else {
                        print("이미지 변환 실패")
                    }
                })
        }
    }
}

