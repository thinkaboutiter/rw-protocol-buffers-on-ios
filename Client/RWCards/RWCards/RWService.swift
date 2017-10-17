/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation
import Alamofire
import SimpleLogger

class RWService {
    // singletone
	static let shared = RWService()
    
    // MARK: - Initialization
	private init() { }
    
    // MARK: - Networking
    func getCurrentUser(
        success: @escaping (_ contact: Contact) -> Void,
        failure: @escaping (_ error: NSError) -> Void)
    {
        Alamofire
            .request(
                "\(AppConstants.ApiResource.baseUrlString)\(AppConstants.ApiResource.EndPoint.currentUser)",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: nil)
            .responseData { (dataResponse: DataResponse<Data>) in
                
                // log request and response objects
                Logger.network.message("request:").object(dataResponse.request)
                Logger.network.message("request.allHTTPHeaderFields:").object(dataResponse.request?.allHTTPHeaderFields)
                Logger.network.message("response:").object(dataResponse.response)
                Logger.network.message("timeline:").object(dataResponse.timeline)
                
                // check `dataResponse`
                let responseError: NSError? = self.checkWebServiceResponse(dataResponse)
                guard responseError == nil else {
                    failure(responseError!)
                    return
                }
                
                // check data
                guard let valid_data: Data = dataResponse.result.value else {
                    Logger.error.message("Invalid result object")
                    
                    // create error object
                    let error: NSError = ErrorCreator.invalidResultObject.error()
                    failure(error)
                    return
                }
                
                // try creating a `Contact` object
                guard let valid_contact: Contact = try? Contact(serializedData: valid_data) else {
                    let errorMessage: String = "Unable to create \(String(describing: Contact.self)) object!"
                    Logger.error.message(errorMessage)
                    
                    // create error
                    let error: NSError = ErrorCreator.custom(code: ErrorCreator.teapotCode, message: errorMessage).error()
                    failure(error)
                    return
                }
                
                success(valid_contact)
        }
    }
    
    func getSpeakers(
        success: @escaping (_ speakers: Speakers) -> Void,
        failure: @escaping (_ error: NSError) -> Void)
    {
        Alamofire
            .request(
                "\(AppConstants.ApiResource.baseUrlString)\(AppConstants.ApiResource.EndPoint.speakers)",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: nil)
            .responseData { (dataResponse: DataResponse<Data>) in
                
                // log request and response objects
                Logger.network.message("request:").object(dataResponse.request)
                Logger.network.message("request.allHTTPHeaderFields:").object(dataResponse.request?.allHTTPHeaderFields)
                Logger.network.message("response:").object(dataResponse.response)
                Logger.network.message("timeline:").object(dataResponse.timeline)
                
                // check `dataResponse`
                let responseError: NSError? = self.checkWebServiceResponse(dataResponse)
                guard responseError == nil else {
                    failure(responseError!)
                    return
                }
                
                // check data
                guard let valid_data: Data = dataResponse.result.value else {
                    Logger.error.message("Invalid result object")
                    
                    // create error object
                    let error: NSError = ErrorCreator.invalidResultObject.error()
                    failure(error)
                    return
                }
                
                // try creating a `Speakers` object
                guard let valid_speakers: Speakers = try? Speakers(serializedData: valid_data) else {
                    let errorMessage: String = "Unable to create \(String(describing: Contact.self)) object!"
                    Logger.error.message(errorMessage)
                    
                    // create error
                    let error: NSError = ErrorCreator.custom(code: ErrorCreator.teapotCode, message: errorMessage).error()
                    failure(error)
                    return
                }
                
                success(valid_speakers)
        }
    }
}

// MARK: - Response check
fileprivate extension RWService {
    
     /**
     Error Check mechanism for all webServices
     - parameter response: Alamofire response to check
     - returns: optional error if such is present
     */
    func checkWebServiceResponse<T>(_ response: DataResponse<T>) -> NSError? {
        // check for success
        guard response.result.isSuccess else {
            Logger.error.message("Error fetching data:").object(response.result.error)
            
            // create error object
            let error: NSError = ErrorCreator.generic.error()
            return error
        }
        
        // check response object
        guard let valid_response: HTTPURLResponse = response.response else {
            Logger.error.message("Invalid response object")
            
            // create error object
            let error: NSError = ErrorCreator.invalidResponseObject.error()
            return error
        }
        
        // check status code
        guard 200...299 ~= valid_response.statusCode else {
            Logger.error.message("Invalid status code: \(valid_response.statusCode)")
            
            // create error object
            let error: NSError = ErrorCreator.custom(code: valid_response.statusCode, message: "\(AppConstants.ErrorMessage.invalidStatusCode) \(valid_response.statusCode)").error()
            return error
        }
        
        return nil
    }
}
