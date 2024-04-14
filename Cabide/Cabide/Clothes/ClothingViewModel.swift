//
//  ClothingViewModel.swift
//  Cabide
//
//  Created by Eduardo Brum on 31/03/24.
//

import Database
import DependencyInjection
import SwiftUI

class ClothingViewModel: ObservableObject {
    @Injected var repo: any Repository<Clothing>
    @Published var clothes: [Clothing] = []
    
    @Published var image: UIImage = UIImage()
    
    func updateClothingImage(_ image: UIImage?) {
        guard let image else { return }
        self.image = image
    }
    
    func save() {
        if let img = image.pngData() {
            let clothing = Clothing(image: img)
            // Tries to save a Model (anything that conforms to EntityRepresentable). If it had any trouble, calls completion with nil.
            repo.save(clothing) { model in
                if let model = model {
                    DispatchQueue.main.async {
                        self.clothes.append(model)
                    }
                    
                    print("Created and saved clothing with id \(model.id).")
                } else {
                    print("Failed to create clothing.")
                }
            }
        }
    }
}
