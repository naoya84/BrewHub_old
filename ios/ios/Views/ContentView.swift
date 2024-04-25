//
//  ContentView.swift
//  ios
//
//  Created by naoya on 2024/03/27.
//

import SwiftUI

struct ContentView: View {
    @Binding var path: NavigationPath //path.appendで遷移する場合に使用する
    
    var body: some View {
        List{
            NavigationLink("写真を撮る", value: AppPath.Record)
            NavigationLink("写真一覧を見る", value: AppPath.PhotoIndex)
            NavigationLink("レポートを作成する", value: AppPath.CreateReport)
//            Button("sample"){
//                path.append(AppPath.PhotoIndex)
//            }
        }
    }
}



#Preview {
    ContentView(path: .constant(NavigationPath()))
}
