//
//  ClotheView.swift
//  Cabide
//
//  Created by Eduardo Brum on 31/03/24.
//

import PhotosUI
import SwiftUI

struct ClothingView: View {
    @ObservedObject var viewModel: ClothingViewModel = ClothingViewModel()
    
    var body: some View {
        VStack {
            RemoveBackgroundView(viewModel: viewModel)
        }
    }
}
