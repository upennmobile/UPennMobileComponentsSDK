//
//  UPennJSONSerializer.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/17/21.
//

import Foundation

open class UPennJSONSerializer {
    public enum FileType : String {
        case JSON = "json"
        case TXT = "txt"
    }
    public static func ReadJSONFromFile(fileName: String, fileType: FileType = .JSON, completion: @escaping (_ json: Any?, _ error: Error?)->Void)
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType.rawValue) {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
                completion(json,nil)
            } catch {
                // Handle error here
                completion(nil,error)
            }
        }
    }
}
