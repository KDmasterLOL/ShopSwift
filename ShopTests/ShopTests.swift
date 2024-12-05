//
//  ShopTests.swift
//  ShopTests
//
//  Created by Иван Толмачев on 03.12.2024.
//

import XCTest
import SwiftData
@testable import Shop

final class ShopTests: XCTestCase {
    
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    @MainActor func testFetchProducts() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Product.self, configurations: config)
        ProductRepository.shared.modelContext = container.mainContext
        
        let page = 0
        let limit = 10

        let products = try await ProductRepository.shared.loadProducts(skip: page, limit: limit)

        XCTAssertFalse(products.isEmpty, "Fetched products should not be empty")
        
        let productsFromStorage = try ProductRepository.shared.getProducts()
        
        XCTAssertFalse(productsFromStorage.isEmpty, "Product from storage should not be empty")
    }



    @MainActor func testDeleteProduct() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Product.self, configurations: config)
        let modelContext = container.mainContext
        ProductRepository.shared.modelContext = modelContext
        
        let product = Product.sample[0]
        modelContext.insert(product)
        try modelContext.save()

        try ProductRepository.shared.deleteProduct(id: product.id)

        let products = try ProductRepository.shared.getProducts()
        
        XCTAssertTrue(products.isEmpty, "The product should be deleted")
        
        do {
            try modelContext.delete(model: Product.self)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    @MainActor func testEditProduct() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Product.self, configurations: config)
        let modelContext = container.mainContext
        if ProductRepository.shared.modelContext != nil {
            print("AAAA")
            return
        }
        ProductRepository.shared.modelContext = modelContext
        
        let product = Product.sample[0]
        modelContext.insert(product)
        try modelContext.save()

        let editedProduct = product.copy()
        editedProduct.title = "Edited Title"

        try ProductRepository.shared.editProduct(product: editedProduct)

        let fetchedProduct = try ProductRepository.shared.getProduct(id: product.id)
        XCTAssertEqual(fetchedProduct.title, "Edited Title", "The product title should be updated")
        
        do {
            try modelContext.delete(model: Product.self)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
