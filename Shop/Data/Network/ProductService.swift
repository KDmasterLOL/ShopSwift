//
//  ProductService.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import Foundation
import Alamofire

class ProductService {
    static let shared = ProductService()
    
    private let baseURL = "https://dummyjson.com"

    func getProducts(skip: Int = 0, limit: Int = 20, category: String = "") async throws -> ProductsResponse {
        let url = "\(baseURL)/products\(category.isEmpty ? "" : "/category/\(category)")?limit=\(limit)&skip=\(skip)"
        print("Make request to \(url)")
        let data = try await AF.request(url).serializingData().value
        return try JSONDecoder().decode(ProductsResponse.self, from: data)
    }
    func getProduct(id: Int = 0) async throws -> Product {
        let url = "\(baseURL)/product/\(id)"
        let data = try await AF.request(url).serializingData().value
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON Data: \(jsonString)")
        } else {
            print("Failed to convert data to string")
        }

        let product = try JSONDecoder().decode(Product.self, from: data)
        return product
    }
    
    func getCategories() async throws -> [String] {
        let url = "\(baseURL)/products/category-list"
        let data = try await AF.request(url).serializingData().value

        let categories = try JSONDecoder().decode([String].self, from: data)
  
        return categories
    }
}

struct ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
