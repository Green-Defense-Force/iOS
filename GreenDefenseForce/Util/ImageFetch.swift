//
//  File.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import Combine
import UIKit

enum ImageFetchError: Error {
    case invalidURL
}

final class ImageFetch {
    func imageFetch(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) -> AnyCancellable {
        guard let imageURL = URL(string: url) else {
            completion(.failure(ImageFetchError.invalidURL))
            return AnyCancellable { }
        }
        
        return URLSession.shared.dataTaskPublisher(for: imageURL)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Retrieval failed: \(error)")
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { image in
                completion(.success(image))
            })
    }
}
