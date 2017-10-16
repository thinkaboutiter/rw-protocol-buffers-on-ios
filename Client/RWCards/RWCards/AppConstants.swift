//
//  AppConstants.swift
//  RWCards
//
//  Created by boyankov on W42 16/Oct/2017 Mon.
//  Copyright © 2017 boyankov@yahoo.com. All rights reserved.
//

import Foundation

struct AppConstants {
    
    // MARK: - ApiResource
    struct ApiResource {
        static let baseUrlString: String = "http://127.0.0.1:5000"
        
        struct EndPoint {
            static let currentUser: String = "/currentUser"
            static let speakers: String = "/speakers"
        }
    }
    
    // MARK: - Error messages
    struct ErrorMessage {
        static let generic: String = NSLocalizedString("Something went wrong!", comment: AppConstants.LocalizedStringComment.errorMessage)
        
        /*
         network
         */
        static let unableToParseData: String = NSLocalizedString("Unable to parse data!", comment: AppConstants.LocalizedStringComment.errorMessage)
        static let invalidResultObject: String = NSLocalizedString("Invalid result object!", comment: AppConstants.LocalizedStringComment.errorMessage)
        static let invalidResponseObject: String = NSLocalizedString("Invalid response object!", comment: AppConstants.LocalizedStringComment.errorMessage)
        static let invalidResourcesReceived: String = NSLocalizedString("Invalid resources received!", comment: AppConstants.LocalizedStringComment.errorMessage)
        static let invalidStatusCode: String = NSLocalizedString("Invalid status code!", comment: AppConstants.LocalizedStringComment.errorMessage)
    }
    
    // MARK: - Localized strings comments
    struct LocalizedStringComment {
        static let errorMessage: String = "Error message"
    }
}
