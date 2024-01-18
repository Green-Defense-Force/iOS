//
//  StoreModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 1/17/24.
//

import Foundation

struct StoreModel {
    let userId: String
    let categoryId: String
    let coinAmount: Int
    let storeItems: StoreItem
    let equippedItems: [String: String]
}

struct StoreItem {
    let itemId: String
    let itemTitle: String
    let itemImage: String
    let itemPrice: Int
    let isBuy: Bool
}
