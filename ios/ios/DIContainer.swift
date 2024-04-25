//
//  DIContainer.swift
//  ios
//
//  Created by naoya on 2024/04/07.
//

import Foundation

struct DIContainer{
    let photoRepository: PhotoRepository
    let reportRepository: ReportRepository
    
    static func make()->DIContainer{
        return DIContainer.init(
            photoRepository: PhotoRepositoryImpl(),
            reportRepository: ReportRepositoryImpl()
        )
    }
}
