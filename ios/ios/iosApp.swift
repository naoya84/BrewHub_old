//
//  iosApp.swift
//  ios
//
//  Created by naoya on 2024/03/27.
//

import SwiftUI
import AVFoundation

@main
struct iosApp: App {
    var body: some Scene {
        WindowGroup {
            //DIContainerでstatic func make()しているため、ここで呼び出せる
            //親のViewにrepositoryを注入した状態でcontainerを渡せる
            BrewHubAppContent(container: DIContainer.make())
        }
    }
}

struct BrewHubAppContent:View {
    @State var path = NavigationPath()
    let container: DIContainer
    
    var body: some View {
       
        NavigationStack(path: $path){
            ContentView(path: $path)
                .navigationDestination(for: AppPath.self, destination: self.destination)
        }
    }
    
    //@viewBuilderは複数のviewを1つのviewみなして返す
    @ViewBuilder
    func destination(_ appPath: AppPath) -> some View{
        switch appPath{
        case .Main: ContentView(path: $path)
        case .Record: RecordPageView(
            viewModel: RecordPageView.ViewModel(captureSession: AVCaptureSession(),
            provider: UUIDProviderImpl()
        ))
        case .PhotoIndex: PhotoIndexPageView(container: container)
        case .CreateReport: CreateReportPageView(
            path: $path,
            viewModel: .init(report: Report(id: 0, text: ""), container: container)
        )
        }
    }
}
