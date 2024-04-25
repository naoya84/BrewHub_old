//
//  PhotoIndexPageView.swift
//  ios
//
//  Created by naoya on 2024/04/07.
//

import SwiftUI

struct PhotoIndexPageView: View {
    let container: DIContainer
    
    var body: some View {
        let localPhoto: [LocalPhoto] = container.photoRepository.getAll()
        
        if localPhoto.isEmpty {
            Text("写真がありません")
        }else{
            List {
                ForEach(localPhoto, id: \.self){photo in
                    Image(uiImage: UIImage(contentsOfFile: photo.photoUrl.path) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                }
            }
        }
    }
}

#Preview {
    PhotoIndexPageView(container: DIContainer.make())
}
