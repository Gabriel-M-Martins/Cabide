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
    
    init() {
        _vm = .init(wrappedValue: RemoveBackgroundViewModel())
    }
    
    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
            } else {
                Image(uiImage: vm.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 700, height: 300)
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

#Preview {
    RemoveBackgroundView()
}
