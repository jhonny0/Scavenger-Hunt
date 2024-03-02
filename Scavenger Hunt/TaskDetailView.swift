//
//  TaskDetailView.swift
//  Scavenger Hunt
//
//  Created by Jonathan Fernandez on 3/2/24.
//

import Foundation
import SwiftUI
import PhotosUI
import MapKit // Ensure this is imported to use MKCoordinateRegion, etc.

struct TaskDetailView: View {
    @Binding var task: Task
    @State private var inputImage: UIImage?
    @State private var showingPhotoPickerActionSheet = false
    @State private var showingImagePicker = false // This will now control the presentation of both the photo picker and the camera.
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack {
            if let attachedPhoto = task.attachedPhoto {
                Image(uiImage: attachedPhoto)
                    .resizable()
                    .scaledToFit()
            } else {
                Button("Tap to select a photo") {
                    showingPhotoPickerActionSheet = true
                }
                .foregroundColor(.blue)
            }
            
            if let location = task.photoLocation {
                MapView(coordinate: location.coordinate)
                    .frame(height: 300)
            }
        }
        .navigationTitle(task.title)
        .onChange(of: inputImage) { _ in
            task.attachedPhoto = inputImage
            task.isCompleted = true
            // Assuming location extraction is handled within PhotoPicker
        }
        .actionSheet(isPresented: $showingPhotoPickerActionSheet) {
            ActionSheet(title: Text("Select Photo"), message: Text("Choose a source"), buttons: [
                .default(Text("Camera")) {
                    sourceType = .camera
                    showingImagePicker = true
                },
                .default(Text("Photo Library")) {
                    sourceType = .photoLibrary
                    showingImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $showingImagePicker) {
            if sourceType == .camera {
                ImagePicker(selectedImage: $inputImage, sourceType: .camera)
            } else {
                PhotoPicker(selectedImage: $inputImage, task: $task)
            }
        }
    }
}
