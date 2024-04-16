//
//  ContentViewTests.swift
//  iosTests
//
//  Created by naoya on 2024/04/08.
//

import Nimble
import SwiftUI
import ViewInspector
import XCTest

@testable import ios

final class ContentViewTests: XCTestCase {
    func test_写真を撮るというnavigationLinkをクリックするとRecord画面へ遷移する() throws {
        //Given: ContentViewにいて
        let view = ContentView(path: .constant(NavigationPath()))
        
        //When: NavigationLinkをfindした時
        let navigationLink = try view.inspect().find(navigationLink: "写真を撮る")
        let nextScreenPath = try navigationLink.value(AppPath.self)
        
        //Then: Recordへのパスを持っている
        expect(nextScreenPath).to(equal(AppPath.Record))
    }
    
    func test_写真一覧を見るというnavigationLinkをクリックするとPhotoIndex画面へ遷移する() throws {
        //Given: ContentViewにいて
        let view = ContentView(path: .constant(NavigationPath()))
        
        //When: NavigationLinkをfindした時
        let navigationLink = try view.inspect().find(navigationLink: "写真一覧を見る")
        let nextScreenPath = try navigationLink.value(AppPath.self)
        
        //Then: PhotoIndexへのパスを持っている
        expect(nextScreenPath).to(equal(AppPath.PhotoIndex))
    }
}
