//
//  ContentView.swift
//  Shop
//
//  Created by Иван Толмачев on 03.12.2024.
//

import SwiftUI
import SwiftData
import Alamofire

struct ContentView: View {
    var body: some View {
        ProductList(viewModel: ProductListViewModel())
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
