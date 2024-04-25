//
//  UUIDProvider.swift
//  ios
//
//  Created by naoya on 2024/04/07.
//

import Foundation

protocol UUIDProvider{
    func getUUID() -> String
}

struct UUIDProviderImpl: UUIDProvider{
    func getUUID() -> String {
        UUID().uuidString.lowercased()
    }
}
