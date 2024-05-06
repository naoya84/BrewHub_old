//
//  APIRequest.swift
//  ios
//
//  Created by naoya on 2024/04/30.
//

import Foundation
import Alamofire

typealias Method = HTTPMethod

protocol BaseApiRequest{
    associatedtype ResponseType: Decodable
    associatedtype RequestType
    
    var method: Method { get }
    var url: URL { get }
    var headers: [String: String] {get}
}

protocol UploadAPIRequest: BaseApiRequest{
    var parameters: RequestType {get}
}
