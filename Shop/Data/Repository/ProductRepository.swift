//
//  ProductRepository.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import Foundation
import SwiftData

class ProductRepository {
    static let shared = ProductRepository()
    
    enum RepositryError: Error {
        case modelContextUnitialized
        case productNotFound
    }
    
    var total: Int = 0
    
    public var modelContext: ModelContext? = nil
    
    @MainActor
    func loadProducts(skip: Int, limit: Int, category: String = "") async throws -> [Product] {
        guard let context = modelContext else {
            throw RepositryError.modelContextUnitialized
        }
        let productResponse = try await ProductService.shared.getProducts(skip: skip, limit: limit, category: category)
        total = productResponse.total
        let products = productResponse.products
        
        for product in products {
            context.insert(product)
        }
        
        try context.save()
        
        return products
    }
    @MainActor
    func getProducts(count: Int? = nil, skip: Int = 0, category: String = "") throws -> [Product] {
        guard let context = modelContext else {
            throw RepositryError.modelContextUnitialized
        }
        
        var productQuery = FetchDescriptor<Product>(
            predicate: #Predicate<Product> {
                category.isEmpty ? true : $0.category == category
            },
            sortBy: [SortDescriptor(\Product.id, order: .forward)]
        )
        productQuery.fetchLimit = count
        productQuery.fetchOffset = skip
        
        let results = try context.fetch(productQuery)
        return results
    }
    
    @MainActor
    func getProduct(id: Int) throws -> Product {
        guard let context = modelContext else {
            throw RepositryError.modelContextUnitialized
        }
        
        var productQuery = FetchDescriptor<Product>(
            predicate: #Predicate { $0.id == id }
        )
        productQuery.fetchLimit = 1
        productQuery.includePendingChanges = true
        
        let results = try context.fetch(productQuery)
        return results[0]
    }
    @MainActor
    func deleteProduct(id: Int) throws {
        guard let context = modelContext else {
            throw RepositryError.modelContextUnitialized
        }
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == id })
        let products = try context.fetch(descriptor)
        for product in products {
            context.delete(product)
        }
        try context.save()
    }
    @MainActor
    func editProduct(product: Product) throws -> Product {
        guard let context = modelContext else {
            throw RepositryError.modelContextUnitialized
        }
        let descriptor = FetchDescriptor<Product>(predicate: #Predicate { $0.id == product.id })
        let products = try context.fetch(descriptor)
        if let existingProduct = products.first {
            existingProduct.title = product.title
            existingProduct.productDescription = product.productDescription
            existingProduct.thumbnail = product.thumbnail
            try context.save()
            return existingProduct
        } else {
            throw RepositryError.productNotFound
        }
        
    }
    
}
