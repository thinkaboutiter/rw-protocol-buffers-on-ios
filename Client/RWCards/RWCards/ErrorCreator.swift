//
//  ErrorCreator.swift
//  RWCards
//
//  Created by boyankov on W42 16/Oct/2017 Mon.
//  Copyright © 2017 boyankov@yahoo.com. All rights reserved.
//

import Foundation

enum ErrorCreator {
    case generic
    case unableToParseData
    case invalidResultObject
    case invalidResponseObject
    case invalidResourcesReceived
    case custom(code: Int, message: String)
    
    static let domain: String = "MektoubeErrorDomain"
    static let teapotCode: Int = 418
    
    func error() -> NSError {
        switch self {
        case .generic:
            return self.createErrorWithDomain(ErrorCreator.domain, code: ErrorCreator.teapotCode, message: AppConstants.ErrorMessage.generic)
            
        case .unableToParseData:
            return self.createErrorWithDomain(ErrorCreator.domain, code: ErrorCreator.teapotCode, message: AppConstants.ErrorMessage.unableToParseData)
            
        case .invalidResultObject:
            return self.createErrorWithDomain(ErrorCreator.domain, code: ErrorCreator.teapotCode, message: AppConstants.ErrorMessage.invalidResultObject)
            
        case .invalidResponseObject:
            return self.createErrorWithDomain(ErrorCreator.domain, code: ErrorCreator.teapotCode, message: AppConstants.ErrorMessage.invalidResponseObject)
            
        case .invalidResourcesReceived:
            return self.createErrorWithDomain(ErrorCreator.domain, code: ErrorCreator.teapotCode, message: AppConstants.ErrorMessage.invalidResourcesReceived)
            
        case .custom(let code, let message):
            return self.createErrorWithDomain(ErrorCreator.domain, code: code, message: message)
        }
    }
    
    fileprivate func createErrorWithDomain(_ domain: String, code: Int, message: String) -> NSError {
        let error: NSError = NSError(
            domain: domain,
            code: code,
            userInfo: [
                NSLocalizedDescriptionKey: message
            ])
        
        return error
    }
}
