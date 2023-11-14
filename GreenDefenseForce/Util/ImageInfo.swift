//
//  GitHubFile.swift
//  GreenDefenseForce
//
//  Created by 이완재 on 11/14/23.
//

import Foundation

struct GitHubFile: Codable {
    let payload: Payload
    
    struct Payload: Codable {
        let tree: Tree
    }
    
    struct Tree: Codable {
        let items: [TreeItem]
    }
    
    struct TreeItem: Codable {
        let name: String
        let path: String
        let contentType: String
    }
    
}
