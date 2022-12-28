//
//  JSONDownloader.swift
//  Hava Durumu
//
//  Created by Halil YAŞ on 28.12.2022.
//

import Foundation

class JSONDownloader {
    
    let session : URLSession
    
    init(config : URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config: .default)
    }
    
    typealias JSON = [String : AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON?, APIError?) -> Void
    
    func jsonTask(with request : URLRequest, completionHandler completion : @escaping JSONDownloaderCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil,APIError.RequestError)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    
                    // Data geldiyse
                    do {
                        let json = try JSONSerialization.jsonObject(with: data,options: []) as? JSON
                        completion(json,nil)
                    } catch {
                        completion(nil,APIError.JSONParsingError)
                    }
                    
                } else {
                    //data da sorun varsa
                    completion(nil,APIError.invalidData)
                }
                
            } else {
                //hata meydana geldi
                
                completion(nil,APIError.ReponseUnsuccesful(statusCode: httpResponse.statusCode))
            }
        }
        
        return task
    }
}
