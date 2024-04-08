//
//  CALayerView.swift
//  ios
//
//  Created by naoya on 2024/04/06.
//

import SwiftUI

struct CALayerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    var caLayer: CALayer
    
    func makeUIViewController(context: Context) -> UIViewController {
        //単にUIViewControllerの新しいインスタンスを作成するだけ
        let viewController = UIViewController()
        //新しく作成したUIViewControllerのviewプロパティにCALayerを追加しています
        viewController.view.layer.addSublayer(caLayer)
        //calayerのframeをviewのframeに合わせる
        caLayer.frame = viewController.view.layer.frame
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        caLayer.frame = uiViewController.view.layer.frame
    }
        
}

