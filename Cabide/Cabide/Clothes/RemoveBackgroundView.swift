//
//  PhotoPickerView.swift
//  Cabide
//
//  Created by Eduardo Brum on 31/03/24.
//

import Database
import DependencyInjection
import PhotosUI
import SwiftUI

struct RemoveBackgroundView: View {
    @StateObject private var vm: RemoveBackgroundViewModel
    
    @State private var photoPickerItem: PhotosPickerItem?
    var updateClothingImageClosure: ((UIImage) -> Void)?
    
    init(updateClothingImageClosure: ((UIImage) -> Void)?) {
        _vm = .init(wrappedValue: RemoveBackgroundViewModel(updateClothingImageClosure: updateClothingImageClosure))
    }
    
    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
            } else {
                PhotosPicker("Select photo", selection: $photoPickerItem, matching: .images)
            }
        }
        .onChange(of: photoPickerItem) {
            Task {
                if let data = try? await photoPickerItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        vm.removeBackground(inputClothingImage: uiImage)
                    }
                } else {
                    print("Failed")
                }
            }
        }
    }
}

//#Preview {
//    RemoveBackgroundView()
//}
