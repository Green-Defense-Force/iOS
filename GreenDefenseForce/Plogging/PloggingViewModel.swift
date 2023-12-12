//
//  PloggingViewModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 12/9/23.
//

import Foundation

class PloggingViewModel {
    
    var ploggingModel: PloggingModel?
    
    func fetch() {
        ploggingModel = PloggingModel(userId: "1", ploggingTime: "", ploggingDistance: 5, trashCount: 1)
    }
}
