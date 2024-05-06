//
//  DIContainer.swift
//  ios
//
//  Created by naoya on 2024/04/07.
//

import Foundation
import Alamofire

struct DIContainer{
    let photoRepository: PhotoRepository
    let reportRepository: ReportRepository
    
    static func make()->DIContainer{
        let apiClient = AFAPIClient(session: Session())
        
        return DIContainer.init(
            photoRepository: PhotoRepositoryImpl(),
            reportRepository: ReportRepositoryImpl(apiClient: apiClient)
        )
    }
}
