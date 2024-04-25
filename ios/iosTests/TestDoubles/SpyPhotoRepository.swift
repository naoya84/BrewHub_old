//
//  SpyPhotoRepository.swift
//  iosTests
//
//  Created by naoya on 2024/04/09.
//

import Foundation
@testable import ios

struct SpyPhotoRepository: PhotoRepository{
    public var getAll_returnValue:[LocalPhoto] = []
    
    func getAll() -> [LocalPhoto] {
        return getAll_returnValue
    }
}
