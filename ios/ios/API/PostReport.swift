//
//  PostReport.swift
//  ios
//
//  Created by naoya on 2024/04/30.
//

import Foundation
import Alamofire
import OpenAPIClient

struct PostReport: UploadAPIRequest {
    typealias ResponseType = String
    typealias RequestType = SaveReportBody
    
    let url: URL
    let parameters: SaveReportBody
    let method: Method = .post
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}

