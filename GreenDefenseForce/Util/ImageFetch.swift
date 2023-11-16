//
//  File.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import Combine
import UIKit


final class ImageFetch {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    func imageFetch(url: String) -> AnyPublisher<UIImage, Error>{
        guard let imageURL = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: imageURL)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) 
                else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .compactMap { UIImage(data: $0) }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError(statusCode: Int)
}
