//
//  PhotoPicket.swift
//  Scavenger Hunt
//
//  Created by Jonathan Fernandez on 3/2/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    @Binding var task: Task
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            // Check if the first item contains a valid asset identifier.
            guard let itemProvider = results.first?.itemProvider,
                  let identifier = results.first?.assetIdentifier else {
                return
            }
            
            // Fetch the asset from the Photos library.
            let asset = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil).firstObject
            
            // Load the image for the selected asset.
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self?.parent.selectedImage = image
                            // Extract and set the location data here
                            self?.parent.task.photoLocation = asset?.location
                        }
                    }
                }
            }
        }
    }
}
