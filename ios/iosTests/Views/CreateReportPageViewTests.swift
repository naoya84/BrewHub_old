//
//  CreateReportPageViewTests.swift
//  iosTests
//
//  Created by naoya on 2024/04/14.
//

import Nimble
import SwiftUI
import ViewInspector
import XCTest

@testable import ios

final class CreateReportPageViewTests: XCTestCase {
    func test_投稿ボタンがある() throws {
        //Given: CreateReportページにいて
        let view = CreateReportPageView(
            path: .constant(NavigationPath()),
            viewModel: .init(
                report: Report.init(text: ""),
                container: DIContainer.make()
            )
        )
        
        //When: 投稿ボタンをfindした時
        let submitButton = try view.inspect().find(button: "投稿")
        
        //Then: nilではない
        expect(submitButton).toNot(beNil())
    }
    
    func test_投稿ボタンを押すとcreateメソッドが呼ばれる() throws {
        let spyReportRepository = SpyReportRepository()
        
        //Given: CreateReportページにいて
        let view = CreateReportPageView(
            path: .constant(NavigationPath()),
            viewModel: .init(
                report: Report.init(text: ""),
                container: DIContainer.makeTestDouble(
                    spyReportRepository: spyReportRepository
                )
            )
        )
        
        //When: 投稿ボタンを押した時
        let submitButton = try view.inspect().find(button: "投稿")
        try submitButton.tap()
        
        //Then: createメソッドが正しく呼ばれる
        expect(spyReportRepository.create_wasCalled).to(beTrue())
        
    }
    
    func test_投稿ボタンを押すと前のMain画面に遷移する() throws {
        let path = Binding(wrappedValue:
            NavigationPath(
                [
                    AppPath.Main,
                    AppPath.CreateReport
                ]
            )
        )
        
        //Given: CreateReportページにいて
        let view = CreateReportPageView(
            path: path,
            viewModel: .init(
                report: Report.init(text: ""),
                container: DIContainer.make()
            )
        )
        
        //When: 投稿ボタンを押した時
        let submitButton = try view.inspect().find(button: "投稿")
        try submitButton.tap()
        
        //Then: Mainページへのリンクを持っている
        expect(path.wrappedValue).to(equal(NavigationPath([
            AppPath.Main,
            AppPath.CreateReport,
            AppPath.Main
        ])))
    }
}

//Given:


//When:


//Then:

