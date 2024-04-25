//
//  CreateReportRepository.swift
//  ios
//
//  Created by naoya on 2024/04/14.
//

import Foundation
import Alamofire

protocol ReportRepository{
    func create(report: Report)->String
}

struct ReportRepositoryImpl: ReportRepository{
    func create(report: Report) -> String {        
        let res = AF.request(
            "http://localhost:8080/api/report/create"
        ).responseJSON {response in
            switch response.result {
            case .success:
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return report.text //TODO: later
    }
}
