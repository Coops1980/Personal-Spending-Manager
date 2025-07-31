//
//  PhotoPickerView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 01/08/2025.
//


import PhotosUI
import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    var onImagePicked: (String) -> Void  // Or URL/UIImage depending on what you're storing

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(onImagePicked: onImagePicked)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var onImagePicked: (String) -> Void

        init(onImagePicked: @escaping (String) -> Void) {
            self.onImagePicked = onImagePicked
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let itemProvider = results.first?.itemProvider,
                  itemProvider.canLoadObject(ofClass: UIImage.self) else { return }

            let filename = UUID().uuidString // You might actually want to save the image to disk here
            onImagePicked(filename)
        }
    }
}
