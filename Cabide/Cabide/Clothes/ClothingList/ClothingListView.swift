//
//  ClothingListView.swift
//  Cabide
//
//  Created by Eduardo Brum on 14/04/24.
//

import SwiftUI

struct ClothingListView: View {
    @StateObject private var vm: ClothingListViewModel
    
    init() {
        _vm = .init(wrappedValue: ClothingListViewModel())
    }
    
    var body: some View {
        VStack {
            Text("Olá")
            List(vm.clothes, id: \.self) { clothing in
                Image(uiImage: UIImage(data: clothing.image) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 150)
            }
        }
        .onAppear {
            vm.fetchAllClothes()
        }
        
    }
}

#Preview {
    ClothingListView()
}
