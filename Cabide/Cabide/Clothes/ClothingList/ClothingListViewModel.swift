//
//  ClothingListViewModel.swift
//  Cabide
//
//  Created by Eduardo Brum on 14/04/24.
//

import Database
import DependencyInjection
import SwiftUI

class ClothingListViewModel: ObservableObject {
    @Injected var repo: any Repository<Clothing>
    
    @Published var clothes: [Clothing] = []
    @Published var image: UIImage = UIImage()
    
    func fetchAllClothes() {
        self.repo.fetch { (result: [Clothing]) in
            self.clothes = result
            print("Retrieved \(result.count) clothes.")
        }
    }
}
