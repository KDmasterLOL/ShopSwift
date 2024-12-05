//
//  ProductList.swift
//  Shop
//
//  Created by Иван Толмачев on 03.12.2024.
//

import SwiftUI

struct ProductList: View {
    @StateObject var viewModel: ProductListViewModel
    @State var selectedProductId: Int?
    
    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("All").tag(nil as String?)
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category).tag(category as String?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                }
                
                List(selection: $selectedProductId) {
                    ForEach(viewModel.filteredProducts, id: \.id) { product in
                        ProductListItem(product: product).tag(product.id)
                    }
                    .onDelete(perform: viewModel.deleteProduct)
                    if self.viewModel.hasMoreProducts {
                        Text("Fetching more...")
                            .onAppear(perform: {
                                viewModel.loadProducts()
                            })
                    }
                }
            }
        } detail: {
            if let productId = selectedProductId {
                EditProduct(
                    viewModel: EditProductViewModel(product: viewModel.products.first(where: {$0.id == productId})!)
                )
            } else {
                Text("Select an product")
            }
        }
        
    }
    
}



#Preview {
    ProductList(viewModel: ProductListViewModel())
}
