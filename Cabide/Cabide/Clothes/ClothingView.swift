//
//  ClotheView.swift
//  Cabide
//
//  Created by Eduardo Brum on 31/03/24.
//

import PhotosUI
import SwiftUI

struct ClothingView: View {
    @StateObject private var vm: ClothingViewModel
    
    init() {
        _vm = .init(wrappedValue: ClothingViewModel())
    }
    
    var body: some View {
        VStack {
            Image(uiImage: vm.image)
                .resizable()
                .scaledToFit()
                .frame(width: 700, height: 300)
            RemoveBackgroundView { image in
                vm.updateClothingImage(image)
            }
            
            Button("Save") {
                vm.save()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
}
