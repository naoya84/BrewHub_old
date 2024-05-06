//
//  APIClient.swift
//  ios
//
//  Created by naoya on 2024/04/30.
//

import Foundation
import Alamofire

protocol APIClient {
    func upload<T: UploadAPIRequest>(_ request: T) async throws -> T.ResponseType
}

func makeMultipartFormat<T: UploadAPIRequest>(_ request: T) -> MultipartFormData {
    let multipartFormData = MultipartFormData()
    let mirror = Mirror(reflecting: request.parameters)
    for (label, value) in mirror.children {
        guard let label = label else {
            continue
        }
        if let stringValue = value as? String {
            multipartFormData.append(Data(stringValue.utf8), withName: label)
        } else if let uuidValue = value as? UUID {
            multipartFormData.append(Data(uuidValue.uuidString.utf8), withName: label)
        } else if let dateValue = value as? Date {
//            multipartFormData.append(Data(dateValue.toISOString().utf8), withName: label)
        } else if let stringList = value as? [String] {
            multipartFormData.append(Data(stringList.joined(separator: ",").utf8), withName: label)
        } else if let urlValue = value as? URL {
            if urlValue.isFileURL {
                multipartFormData.append(urlValue, withName: label)
            } else {
                multipartFormData.append(
                    urlValue.dataRepresentation,
                    withName: label,
                    fileName: "thumbnail.png",
                    mimeType: "image/png"
                )
            }
        }
    }
    return multipartFormData
}

struct AFAPIClient: APIClient {
    let session: Session
        
    func upload<T>(_ request: T) async throws -> T.ResponseType where T : UploadAPIRequest {
        let multipartFormData = makeMultipartFormat(request)
        
        
        return try await withCheckedThrowingContinuation({ continuation in
            session.upload(
                multipartFormData: multipartFormData,
                to: request.url,
                method: request.method,
                headers: HTTPHeaders(request.headers)
            )
            .responseDecodable(of: T.ResponseType.self, completionHandler: { response in
                print("statusCode: \(String(describing: response.response?.statusCode))")
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    print("================")
                    print(error.localizedDescription)
                    print("================")
                    continuation.resume(throwing: error)
                }
            })
        })
    }
    
}
