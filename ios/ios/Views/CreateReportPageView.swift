//
//  CreateReportPageView.swift
//  ios
//
//  Created by naoya on 2024/04/14.
//

import SwiftUI

struct CreateReportPageView: View {
    @Binding var path: NavigationPath //path.appendで遷移する場合に使用する
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Text("コメント")
        TextEditor(text: $viewModel.report.text)
            .frame(width: 300, height: 300)
            .border(.black)
        Button("投稿"){
            Task {
                await viewModel.sendReport()
            }
            path.append(AppPath.Main)
            print("投稿しました")
        }
    }
}

extension CreateReportPageView {
    class ViewModel: ObservableObject {
        @Published var report: Report
        let container: DIContainer
        
        init(report: Report, container: DIContainer) {
            self.report = report
            self.container = container
        }
        
        func sendReport() async {
            let reportRepository = container.reportRepository
            await reportRepository.create(report: report)
        }
    }
}

#Preview {
    CreateReportPageView(
        path: .constant(NavigationPath()),
        viewModel: .init(report: Report(id: 0,text: ""), container: DIContainer.make())
    )
}
