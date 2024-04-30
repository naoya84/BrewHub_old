//
//  RecordPageView.swift
//  ios
//
//  Created by naoya on 2024/04/06.
//

import SwiftUI
import AVFoundation
import Photos

struct RecordPageView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack{
            CALayerView(caLayer: viewModel.previewLayer)
            Button("Take Photo"){
                viewModel.takePhoto()
            }
        }
    }
    
    class ViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
        @Published var previewLayer: AVCaptureVideoPreviewLayer
        @Published var captureSession: AVCaptureSession
        
        var output: AVCapturePhotoOutput?
        var provider: UUIDProvider
        
        init(captureSession: AVCaptureSession, provider: UUIDProvider) {
            self.captureSession = captureSession
            self.provider = provider
            
            //Inputを指定し、セッションに登録
            guard let backCamera = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: backCamera) else {
                fatalError("Failed to setup camera.")
            }
            captureSession.addInput(input)
            
            //Outputを指定し、セッションに登録
            self.output = AVCapturePhotoOutput()
            if let photoOutput = self.output {
                captureSession.addOutput(photoOutput)
            }
            
            //セッションをレイヤーに登録
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            self.previewLayer = previewLayer
            
            captureSession.startRunning()
        }
        
        func takePhoto() {
            if let photoOutput = self.output {
                let photoSettings = AVCapturePhotoSettings()
                //画面をキャプチャする
                photoOutput.capturePhoto(with: photoSettings, delegate: self)
            }
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print("Error capturing photo: \(error.localizedDescription)")
            } else {
//                if let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) {
//                    savePhotoToLibrary(image: capturedImage)
//                }
                
                let uuid = provider.getUUID()
                if let imageData = photo.fileDataRepresentation() {
                    print(imageData)
                    saveDataToFile(data: imageData, fileName: "\(uuid).png")
                }
            }
        }
        
        func saveDataToFile(data: Data, fileName: String) {
            // ドキュメントディレクトリのパスを取得
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // フォルダのURLを作成
                let folderURL = documentsDirectory.appendingPathComponent("BrewHub/Photo")
                
                if !FileManager.default.fileExists(atPath: folderURL.path){
                    do {
                        try FileManager.default.createDirectory(
                            at: folderURL,
                            withIntermediateDirectories: true,
                            attributes: nil
                        )
                    } catch {
                        print("Failed to create folder: \(error.localizedDescription)")
                        return
                    }
                }
                // ファイルの保存先のURLを作成
                let fileURL = folderURL.appendingPathComponent(fileName)
                
                do {
                    // データをファイルに書き込む
                    try data.write(to: fileURL)
                    print("ファイルが保存されました: \(fileURL)")
                } catch {
                    print("ファイルの保存に失敗しました: \(error.localizedDescription)")
                }
            }
        }
        
        func savePhotoToLibrary(image: UIImage) {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    PHPhotoLibrary.shared().performChanges {
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    } completionHandler: { success, error in
                        if let error = error {
                            print("Error saving photo to library: \(error.localizedDescription)")
                        } else {
                            print("Photo saved to library successfully.")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecordPageView(
        viewModel: RecordPageView.ViewModel(
            captureSession: AVCaptureSession(),
            provider: UUIDProviderImpl()
        )
    )
}
