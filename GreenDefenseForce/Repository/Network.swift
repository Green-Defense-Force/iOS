//
//  Networ.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 1/17/24.
//

import Foundation
import RxSwift
import RxAlamofire

class Network<T: Decodable> {
    
    private let url: String
    private let queue: ConcurrentDispatchQueueScheduler
    
    init(url: String) {
        self.url = url
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func getItemList() -> Observable<T> {
    
        return RxAlamofire.data(.get, url)
            .observe(on: queue)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    func downloadImg() -> Observable<UIImage?> {
        return RxAlamofire.data(.get, url)
            .observe(on: queue)
            .map { data -> UIImage? in
                return UIImage(data: data)
            }
    }
}
