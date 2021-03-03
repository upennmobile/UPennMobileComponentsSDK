//
//  UPennLoginNetworkingService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation

/**
 Completion block representing data returned from network request
 - parameters:
     - responseJSON: optional response object returned from request
     - errorString: optional error String returned from request
     - delete: Bool indicating the request is a deletion type
 */
typealias RequestCompletion = (_ responseJSON: Any?, _ errorString: String?)->Void

class UPennLoginNetworkingService : UPennNetworkRequestable {
    
    func makeLoginRequest(username: String, password: String, completion: @escaping (RequestCompletion)) {
        
        let parameters: [String:String] = [
            "client_id" : "self.configuration.clientID",
            "grant_type" : "password",
            "username" : username,
            "password" : password
        ]
        
        // Make Request for JWT FIXME:
//        let jwtRequest = defaultManager.request(self.configuration.loginEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
//        jwtRequest.responseJSON { (response) in
//            self.unwrapResponseForStatusCode(response, completion: completion)
//        }
    }
}

extension UPennLoginNetworkingService {
    
//  FIXME:   func unwrapResponseForStatusCode(_ response: DataResponse<Any>, delete: Bool=false, completion: (RequestCompletion)) {
//        let hostServerError = "A server with the specified hostname could not be found."
//        if let httpError = response.result.error {
//            completion(nil,httpError.localizedDescription)
//            return
//        }
//        // Unwrap StatusCode & JSON from response
//        guard
//            let statusCode = response.response?.statusCode,
//            let json = response.result.value else
//        {
//            // StatusCode Error
//            completion(nil,statusCodeError)
//            return
//        }
//        // Deleting Notification
//        if statusCode == 204 {
//            completion(nil,nil)
//            return
//        }
//        // Successful JSON fetch
//        if statusCode == 200 {
//            completion(json,nil)
//            return
//        }
//        // Request Error from Server
//        if statusCode == 400 {
//            /*
//             Error structure:
//             ▿ some : 2 elements
//             ▿ 0 : 2 elements
//             - key : incident.Description
//             - value : 'Description' should not be empty.
//             ▿ 1 : 2 elements
//             - key : incident.AffectedUser
//             - value : You must specify an affected user when creating an incident.
//            */
//            var errorBuffer = ""
//            if let errDict = json as? [String:Any]
//            {
//                let errorValues = errDict.values
//                var errorCount = errorValues.count
//                for value in errorValues {
//                    if let v = value as? String {
//                    errorCount-=1
//                        if errorCount == 0 {
//                            errorBuffer+=v
//                        } else {
//                            errorBuffer+="\(v)\n"
//                        }
//                    }
//                }
//                completion(nil,"Errors: \n\(errorBuffer)")
//                return
//            }
//        }
//        // Generic Request Error
//        completion(nil,genericRequestError)
//    }
}
