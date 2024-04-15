//
//  ClothingViewModel.swift
//  Cabide
//
//  Created by Eduardo Brum on 31/03/24.
//

import CoreImage.CIFilterBuiltins
import Database
import DependencyInjection
import SwiftUI
import Vision

class ClothingViewModel: ObservableObject {
    @Injected var repo: any Repository<Clothing>
    
    @Published var clothes: [Clothing] = []
    @Published var image: UIImage = UIImage()
    
    func fetchAllClothes() {
        self.repo.fetch { (result: [Clothing]) in
            self.clothes = result
            print("Retrieved \(result.count) clothes.")
            self.image = UIImage(data: result[0].image) ?? UIImage()
        }
    }
}
