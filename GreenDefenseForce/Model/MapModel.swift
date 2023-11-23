//
//  Model.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/20/23.
//

import UIKit

struct MapModel: Codable  {
    var ticketNum: Int
    var coinNum: Int
    var mapMonsters: [MonsterPreview]
    var character: [String]
    var userName: String
    var userLevel: Int
    var field: String
}


struct MonsterPreview: Codable {
    var monsterId: String
    var monsterImage: String
}
