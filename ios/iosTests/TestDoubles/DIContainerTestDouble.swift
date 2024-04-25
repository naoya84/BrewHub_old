//
//  DIContainerTestDouble.swift
//  iosTests
//
//  Created by naoya on 2024/04/14.
//

import Foundation

@testable import ios

extension DIContainer {
    static func makeTestDouble(
        spyPhotoRepository: SpyPhotoRepository = .init(),
        spyReportRepository: SpyReportRepository = .init()
    ) -> DIContainer{
        return DIContainer.init(
            photoRepository: spyPhotoRepository, 
            reportRepository: spyReportRepository
        )
    }
}
