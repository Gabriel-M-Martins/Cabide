//
//  CabideApp.swift
//  Cabide
//
//  Created by Gabriel Medeiros Martins on 16/03/24.
//

import SwiftUI

@main
struct CabideApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabView {
                DatabaseExampleView()
                    .tabItem {
                        Label("Example", systemImage: "list.dash")
                    }
                ClothingView()
                    .tabItem {
                        Label("Clothes", systemImage: "tshirt")
                    }
            }
        }
    }
}
