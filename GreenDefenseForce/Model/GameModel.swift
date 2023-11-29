//
//  GameModel.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/22/23.
//

import Foundation

struct GameModel: Codable {
    var userId: String
    var attackImages: [String]
    var attackEffect: String
    var monsterId: String
    var monsterTitle: String
    var monsterName: String
    var monsterImage: String
    var monsterHp: Int
    var battleField: String
}
