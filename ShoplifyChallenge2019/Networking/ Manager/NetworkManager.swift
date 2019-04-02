//
//  NetworkManager.swift
//  ShoplifyChallenge2019
//
//  Created by Jackson Ho on 4/1/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

struct NetworkManager {
    
    static let ShoplifyAPIKey = "c32313df0d0ef512ca64d5b336a0d7c6"
    
    static let environment: NetworkEnvironment = .production
    
    private let shoplifyRouter = Router<ShoplifyAPI>()
    
    enum NetworkReponse: String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkReponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkReponse.badRequest.rawValue)
        case 600: return .failure(NetworkReponse.outdated.rawValue)
        default: return .failure(NetworkReponse.failed.rawValue)
        }
    }
    
    func getAllCustomCollections(completion: @escaping (_ error: String?) -> Void) {
        shoplifyRouter.request(.customCollections) { (data, response, error) in
            if error != nil {
                completion("Please check your network connection")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData  = data else { completion(NetworkReponse.noData.rawValue); return }
                    
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: responseData, options: [])
                        print(apiResponse)
                    } catch {
                        completion(NetworkReponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(networkFailureError)
                    
                }
            }
        }
    }
    
}
