//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/30.
//

import Foundation

// LocalizedError 
enum SignupError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        }
    }
}
