//
//  HomeViewController.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/9/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetch()
    }
    
    func setUI() {
        
        setNavigationBlackTitleWhiteBg(title: "게임")
        nvLeftItem(image: UIImage(systemName: "arrow.left")!, action: #selector(backTappedButton), tintColor: .black)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func fetch() {
        let fetch = ImageFetch()
        fetch.imageFetch(url: "https://i.pravatar.cc/") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    print("성공")
                    self?.imageView.image = image
                case .failure(let error):
                    print("실패: \(error)")
                }
            }
        }
        .store(in: &subscriptions)
    }
}
