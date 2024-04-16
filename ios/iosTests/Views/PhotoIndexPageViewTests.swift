//
//  PhotoIndexPageViewTests.swift
//  iosTests
//
//  Created by naoya on 2024/04/09.
//

import Nimble
import SwiftUI
import ViewInspector
import XCTest

@testable import ios

final class PhotoIndexPageViewTests: XCTestCase {
    func test_写真がない場合に写真がありませんと表示される() throws {
        //Given: PhotoIndexPageViewにいて 写真が保存されていなくて
        //写真がない状態をここで作る→Repositoryの戻り値が[]である
        var spyPhotoRepository = SpyPhotoRepository()
        spyPhotoRepository.getAll_returnValue = []
        
        let view = PhotoIndexPageView(container: DIContainer.makeTestDouble())
        
        //When: Text「写真がありません」をfindした時
        let targetText = try view.inspect().find(text: "写真がありません")
        
        //Then: Nilにならない
        expect(targetText).toNot(beNil())
    }
    
    func test_写真がある場合に写真がありませんと表示されない() throws {
        //Given: PhotoIndexPageViewにいて 写真が保存されていて
        var spyPhotoRepository = SpyPhotoRepository()
        spyPhotoRepository.getAll_returnValue = [LocalPhoto(photoUrl: URL(filePath: ""))]
        
        let view = PhotoIndexPageView(container: DIContainer.makeTestDouble())
        
        //When: Text「写真がありません」をfindした時
        //Then: throw errorになる
        expect(try view.inspect().find(text: "写真がありません")).to(throwError())
    }
    
    func test_写真がある場合に写真が表示される() throws {
        //Given: PhotoIndexPageViewにいて 写真が保存されていて
        var spyPhotoRepository = SpyPhotoRepository()
        spyPhotoRepository.getAll_returnValue = [
            LocalPhoto(photoUrl: URL(filePath: "image1")),
            LocalPhoto(photoUrl: URL(filePath: "image2"))
        ]
        
        let view = PhotoIndexPageView(container: DIContainer.makeTestDouble())
        
        //When: Imageをfindした時
        let targetImage = try view.inspect().findAll(ViewType.Image.self)
        
        //Then: Nilにならない
        expect(targetImage.isEmpty).toNot(beTrue())
    }
    
    func test_写真をクリックすると写真が拡大表示される() throws {
        //TODO: later
    }
    
}
