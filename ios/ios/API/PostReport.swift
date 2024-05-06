//
//  PostReport.swift
//  ios
//
//  Created by naoya on 2024/04/30.
//

import Foundation
import Alamofire

struct PostReport: UploadAPIRequest {
    typealias ResponseType = String
    typealias RequestType = SaveParameter
    
    let url: URL
    let parameters: RequestType
    let method: Method = .post
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}

