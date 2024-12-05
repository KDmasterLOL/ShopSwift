//
//  ShopApp.swift
//  Shop
//
//  Created by Иван Толмачев on 03.12.2024.
//

import SwiftUI
import SwiftData

@main
struct ShopApp: App {
    var sharedModelContainer: ModelContainer
    
    init(){
        self.sharedModelContainer = {
            let schema = Schema([
                Product.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        let context = self.sharedModelContainer.mainContext
        ProductRepository.shared.modelContext = context
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
