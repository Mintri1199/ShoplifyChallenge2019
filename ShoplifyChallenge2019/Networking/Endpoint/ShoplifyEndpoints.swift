//
//  ShoplifyEndpoints.swift
//  ShoplifyChallenge2019
//
//  Created by Jackson Ho on 4/1/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public enum ShoplifyAPI {
    case customCollections
}

extension ShoplifyAPI: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production:
            return "https://shopicruit.myshopify.com/admin"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configure") }
        return url
    }
    
    // Why does the endpoints are JSON file name?
    var path: String {
        switch self {
        case .customCollections:
            return "/custom_collections.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .customCollections:
            return .requestParameter(bodyParameters: nil,
                                     urlParameters: ["page" : 1,
                                                     "access_token" : NetworkManager.ShoplifyAPIKey ])
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
