//
//  Product.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import SwiftUI

struct EditProduct: View {
    @ObservedObject var viewModel: EditProductViewModel
    @Environment(\.isPresented) var isPresented
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Product Information") {
                TextField("ID",value: $viewModel.editedProduct.id, formatter: NumberFormatter())
                    .disabled(true)
                TextField("Title", text: $viewModel.editedProduct.title)
                TextField("Description", text: $viewModel.editedProduct.productDescription)
                TextField("Thumbnail", text: $viewModel.editedProduct.thumbnail)
            }
            Button(action: {
                viewModel.saveProduct()
                dismiss()
            }) {
                Text("Save")
            }
            .disabled(viewModel.isLoading)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Edit Product")
        .navigationBarItems(leading: Button("Cancel") {
            dismiss()
            viewModel.editedProduct = viewModel.product.copy()
        })
        
    }
}

#Preview {
    EditProduct(viewModel: EditProductViewModel(product: Product.sample[0]))
}
