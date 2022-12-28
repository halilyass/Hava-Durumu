//
//  APIError.swift
//  Hava Durumu
//
//  Created by Halil YAŞ on 28.12.2022.
//

import Foundation

enum APIError {
    
    case RequestError
    case ReponseUnsuccesful(statusCode : Int)
    case invalidData
    case JSONParsingError
    case invalidURL 
}
