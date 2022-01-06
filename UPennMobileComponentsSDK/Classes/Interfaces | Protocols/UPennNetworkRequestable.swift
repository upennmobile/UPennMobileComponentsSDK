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

/**
 Struct for setting parameter encoding-type on network requests
 - JSON: sets Content-Type to applicatoin/x-www-form-urlencoded
 - URL: sets Content-Type to application/json
 */
public struct UPennRequestEncoding {
    
    public enum EncodingType : String {
        case JSON = "json"
        case URL = "url"
    }
}

public protocol UPennNetworkRequestable {
    
    var urlProvider : UPennURLProvidable { get set }
}

public struct UPennHTTPMethod : RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = UPennHTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = UPennHTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = UPennHTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = UPennHTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = UPennHTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = UPennHTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = UPennHTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = UPennHTTPMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = UPennHTTPMethod(rawValue: "TRACE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}



public extension UPennNetworkRequestable {

    func makeGETRequest(urlStr: String, parameters: UPennParametersDict?=nil, headers: UPennHeadersDict?=nil, encoding: UPennRequestEncoding.EncodingType, completion: @escaping (UPennRequestCompletion)) -> Void {
        guard let _headers = headers else {
            self.makeGETRequestToAF(urlStr: urlStr, parameters: parameters, encoding: encoding, completion: completion)
            return
        }
        self.makeGETRequestToAF(urlStr: urlStr, parameters: parameters, headers: HTTPHeaders(_headers), encoding: encoding, completion: completion)
    }
    
    /** Make a POST request to the UPenn servers
    - parameters:
     - urlStr: String representing URL endpoint
     - parameters: Dictionary of parameters
     - headers:
     */
    func makePOSTRequest(urlStr: String, parameters: UPennParametersDict?=nil, headers: UPennHeadersDict?=nil, encoding: UPennRequestEncoding.EncodingType, completion: @escaping (UPennRequestCompletion)) -> Void {
    // Example let login = UPennLoginCreds(email: "test@test.test", password: "testPassword")
        guard let _headers = headers else {
            self.makePOSTRequestToAF(urlStr: urlStr, parameters: parameters, encoding: encoding, completion: completion)
            return
        }
        self.makePOSTRequestToAF(urlStr: urlStr, parameters: parameters, headers: HTTPHeaders(_headers), encoding: encoding, completion: completion)
    }
    
    /// Upload multi-part form data to UPenn servers
    func upload(
        urlString: String,
        imageData: Data,
        uploadName: String?=nil,
        filename: String,
        headers: UPennHeadersDict?=nil,
        completion: @escaping (UPennRequestCompletion)) {
        
        guard let _headers = headers else {
            self.uploadToAF(urlString: urlString, imageData: imageData, uploadName: uploadName, filename: filename, completion: completion)
            return
        }
        
        self.uploadToAF(urlString: urlString, imageData: imageData, uploadName: uploadName, filename: filename, headers: HTTPHeaders(_headers), completion: completion)
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
    func unwrapResponseForStatusCode(_ response: AFDataResponse<Any>, delete: Bool=false, completion: (UPennRequestCompletion)) {
        
        if
            let httpError = response.error,
            let statusCode = response.response?.statusCode
        {
            if statusCode == 401 {
               // Fire Notification to logout
                UPennNotificationManager.SendExpiredAuthenticationNotification()
            } else {
                completion(nil,httpError.localizedDescription)
            }
            return
        }
        // Unwrap StatusCode & JSON from response
        guard
            let statusCode = response.response?.statusCode,
            let json = response.value else
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
        if statusCode == 401 {
            UPennNotificationManager.SendExpiredAuthenticationNotification()
            return
        }
        
        if statusCode == 400 {
            
            guard let json = response.value as? UPennStringDict else {
                completion(nil,"ERROR: Could not complete your request, please try again.")
                return
            }
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

private extension UPennNetworkRequestable {
    
    func makeGETRequestToAF(
        urlStr: String,
        parameters: Parameters?=nil,
        headers: HTTPHeaders?=nil,
        encoding: UPennRequestEncoding.EncodingType,
        completion: @escaping (UPennRequestCompletion)) {
        
        switch encoding {
        case .JSON:
            AF.request(
                urlStr,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers).responseJSON { response in
                
                self.unwrapResponseForStatusCode(response, completion: completion)
            }
        case .URL:
            AF.request(
                urlStr,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers).responseJSON { response in
                
                self.unwrapResponseForStatusCode(response, completion: completion)
            }
        }
    }
    
    func makePOSTRequestToAF(
        urlStr: String,
        parameters: Parameters?=nil,
        headers: HTTPHeaders?=nil,
        encoding: UPennRequestEncoding.EncodingType,
        completion: @escaping (UPennRequestCompletion)) {
        
        switch encoding {
        case .JSON:
            AF.request(
                urlStr,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers).responseJSON { response in
                
                self.unwrapResponseForStatusCode(response, completion: completion)
            }
        case .URL:
            AF.request(
                urlStr,
                method: .post,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers).responseJSON { response in
                
                self.unwrapResponseForStatusCode(response, completion: completion)
            }
        }
    }
    
    func uploadToAF(
        urlString: String,
        imageData: Data,
        uploadName: String?=nil,
        filename: String,
        headers: HTTPHeaders?=nil,
        completion: @escaping (UPennRequestCompletion)) {
        
        do {
            let request = try URLRequest(url: urlString, method: .post, headers: headers)
            AF.upload(multipartFormData: { (formData) in
                // Append additional format-typing to formData
                formData.append(
                    imageData,
                    withName: uploadName ?? "AddAttachment",
                    fileName: filename,
                    mimeType: "image/jpeg")
            }, with: request).responseJSON { (response) in
                self.unwrapResponseForStatusCode(response, completion: completion)
            }
        } catch {
            print(error)
        }
    }
}
