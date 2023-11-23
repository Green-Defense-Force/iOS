//
//  File.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/12/23.
//

import Combine
import UIKit


final class NetworkService {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func imageFetch<T>(url: String, transformer: @escaping (Data) -> T?) -> AnyPublisher<T, Error>{
        guard let imageURL = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: imageURL)
            .tryMap { result -> T in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                guard let transformedData = transformer(result.data) else {
                    throw NetworkError.dataTransformationError
                }
                
                return transformedData
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError(statusCode: Int)
    case dataTransformationError
}
