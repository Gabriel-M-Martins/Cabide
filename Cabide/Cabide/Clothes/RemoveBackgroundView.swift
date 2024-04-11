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
    @ObservedObject var viewModel: ClothingViewModel
    
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var clothingImage: Image?
    
    init(viewModel: ClothingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Image(uiImage: viewModel.image)
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
                        viewModel.removeBackground(inputClothingImage: uiImage)
                    }
                } else {
                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    RemoveBackgroundView(viewModel: ClothingViewModel())
}
