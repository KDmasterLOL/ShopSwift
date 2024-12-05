//
//  ProductListViewModel.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    @Published var isLoading: Bool = false
    @Published var hasMoreProducts: Bool = true
    @Published var selectedCategory: String? {
        didSet {
            products = []
            currentPage = 0
            hasMoreProducts = true
            loadProducts()
        }
    }
    @Published var categories: [String] = []
    
    var filteredProducts: [Product] {
        guard let category = selectedCategory else { return products }
        return products.filter { product in
            product.category == category
        }
       }
    private var currentPage = 0
    private let limit: Int = 10
    
    init() {
        loadProducts()
        
         Task { @MainActor in
            do {
                categories = try await ProductService.shared.getCategories()
            } catch {
                print("Can't get categories")
            }
        }
    }
    
    func loadProducts() {
        print("Start loading products")
        if isLoading { return }
        isLoading = true
        print("Start loading products isLoading = true")

        Task {
            do {
                let newProducts = try await ProductRepository.shared.loadProducts(skip: limit*currentPage, limit: limit, category: selectedCategory ?? "")
                print("Count of new products \(newProducts.count) from page \(currentPage) with category \(selectedCategory)")
                try await Task.sleep(for: .seconds(1))
                try await MainActor.run {
                    if newProducts.isEmpty {
                        self.hasMoreProducts = false
                    }
                    else {
                        self.hasMoreProducts = true
                        self.products = try ProductRepository.shared.getProducts(count:(currentPage+1)*limit, category: selectedCategory ?? "")
                        print("Get products \(products.count)")
                        currentPage+=1
                    }
                    self.isLoading = false
                }
            } catch {
                print("Error fetching products: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
            
        }
    }
    
    @MainActor
    func deleteProduct(indexSet: IndexSet) {
        do {
            try indexSet.forEach({
                let id = filteredProducts[$0].id
                try ProductRepository.shared.deleteProduct(id: id)
                print("Deleted product with id \(id)")
            })
            products.remove(atOffsets: indexSet)
            
        }
        catch {
            print("Exception while try to delete product")
        }
    }
}
