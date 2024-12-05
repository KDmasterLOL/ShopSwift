//
//  ProductEditViewModel.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import Foundation
import Combine

class EditProductViewModel: ObservableObject {
    @Published var product: Product
    @Published var editedProduct: Product
    @Published var isLoading: Bool = false

    init(product: Product) {
        self.product = product
        self.editedProduct = product.copy()
    }

    func saveProduct() {
        isLoading = true
        product = editedProduct
        Task {
            do {
                try await ProductRepository.shared.editProduct(product: product)
                await MainActor.run {
                    self.isLoading = false
                }
            } catch {
                print("Error saving product: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
