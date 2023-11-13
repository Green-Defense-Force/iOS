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
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        viewModel.fetchImage()
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
    
    func bind() {
        viewModel.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                if let loadedImage = image {
                    print("성공")
                    self?.imageView.image = loadedImage
                }
            }
            .store(in: &subscriptions)
    }
}
