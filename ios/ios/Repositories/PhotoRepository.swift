//
//  PhotoRepository.swift
//  ios
//
//  Created by naoya on 2024/04/07.
//

import Foundation

protocol PhotoRepository{
    func getAll() -> [LocalPhoto]
}

struct PhotoRepositoryImpl: PhotoRepository{
    func getAll() -> [LocalPhoto]{
        var localPhoto: [LocalPhoto] = []
        var directoryContents: [URL] = []
        
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let folderURL = documentsDirectory.appendingPathComponent("BrewHub/Photo")
            
            directoryContents = try FileManager.default.contentsOfDirectory(
                at: folderURL,
                includingPropertiesForKeys: nil,
                options: []
            )
            for url in directoryContents{
                localPhoto.append(LocalPhoto(photoUrl: url))
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
        
        return localPhoto
    }
}
