//
//  SpyReportRepository.swift
//  iosTests
//
//  Created by naoya on 2024/04/14.
//

import Foundation
@testable import ios

class SpyReportRepository: ReportRepository{
    public var create_wasCalled = false
    
    func create(report: Report) -> String {
        create_wasCalled = true
        return ""
    }
}
