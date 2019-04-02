//
//  CategoriesModel.swift
//  ShoplifyChallenge2019
//
//  Created by Jackson Ho on 4/1/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct Collections: Codable {
    let customCollections: [CategoryModel]
    
    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

struct CategoryModel: Codable {
    let id: Int
    let title: String
}
