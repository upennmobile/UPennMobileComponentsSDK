//
//  UPennNetworkRequestable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation
import Alamofire

struct UPennLoginCreds: Encodable {
    let email: String
    let password: String
}

public protocol UPennNetworkRequestable {
    
    var urlProvider : UPennURLProvidable { get set }
}

public extension UPennNetworkRequestable {
    
    // TODO: Extension var for defaultRequest to be available in all conforming classes?
    /**
     Configure SessionManager within Alamofire
    */
//    let defaultManager: SessionDelegate = {
//        let serverTrustPolicies = [String:ServerTrustPolicy]()
//
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//
//        return SessionManager(
//            configuration: configuration,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//    }()

    func makeGETRequest(urlStr: String, completion: @escaping (UPRequestCompletion)) -> Void {

        AF.request(urlStr).responseJSON { response in
            debugPrint(response)
            self.unwrapResponseForStatusCode(response, completion: completion)
        }
    }
    
    func makePOSTRequest(parameters: Parameters, urlStr: String, completion: @escaping (UPRequestCompletion)) -> Void {
    // Example let login = UPennLoginCreds(email: "test@test.test", password: "testPassword")

        AF.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            debugPrint(response)
            self.unwrapResponseForStatusCode(response, completion: completion)
        }
    }
    
    var statusCodeError : String {
        return "Cannot get a Status Code for your Request. Please try again."
    }
    
    var genericRequestError : String {
        return "Something went wrong with your Request. Please try again."
    }
    
    var networkError : String {
        return "Lost connection to PennMedicine WiFi."
    }
    
    var hostServerError : String {
        return "A server with the specified hostname could not be found."
    }
    
    // TODO: Extension func for handling AF responses?
    func unwrapResponseForStatusCode(_ response: AFDataResponse<Any>, delete: Bool=false, completion: (UPRequestCompletion)) {
        
        if let httpError = response.error {
            completion(nil,httpError.localizedDescription)
            return
        }
        // Unwrap StatusCode & JSON from response
        guard
            let statusCode = response.response?.statusCode,
            let json = response.value as? UPStringDict else
        {
            // StatusCode Error
            completion(nil,self.statusCodeError)
            return
        }
        // Deleting Notification
        if statusCode == 204 {
            completion(nil,nil)
            return
        }
        // Successful JSON fetch
        if statusCode == 200 {
            completion(json,nil)
            return
        }
        // Request Error from Server
        if statusCode == 400 {
            /*
             Error structure:
             ▿ some : 2 elements
             ▿ 0 : 2 elements
             - key : incident.Description
             - value : 'Description' should not be empty.
             ▿ 1 : 2 elements
             - key : incident.AffectedUser
             - value : You must specify an affected user when creating an incident.
             */
            var errorBuffer = ""
            let errorValues = json.values
            var errorCount = errorValues.count
            for value in errorValues {
                if let v = value as? String {
                    errorCount-=1
                    if errorCount == 0 {
                        errorBuffer+=v
                    } else {
                        errorBuffer+="\(v)\n"
                    }
                }
            }
            completion(nil,"Errors: \n\(errorBuffer)")
            return
        }
        // Generic Request Error
        completion(nil,self.genericRequestError)
    }
}
