//
//  Coordinator.swift
//  CameraAndGalleryTutorial
//
//  Created by Duy Bui on 10/26/19.
//  Copyright © 2019 Duy Bui. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: Image?
    @Binding var imageInPicker: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, uiImage: Binding<UIImage?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
        _imageInPicker = uiImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageInPicker = unwrapImage
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
