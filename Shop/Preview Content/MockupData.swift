//
//  MockupData.swift
//  Shop
//
//  Created by Иван Толмачев on 04.12.2024.
//

import Foundation

extension Product {
    static let sample: [Product] = [
        Product(
            id: 1,
            stock: 5,
            weight: 2,
            minimumOrderQuantity: 24,
            title: "Essence Mascara Lash Princess",
            productDescription: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
            category: "beauty",
            brand: "Essence",
            sku: "RCH45Q1A",
            warrantyInformation: "1 month warranty",
            shippingInformation: "Ships in 1 month",
            availabilityStatus: "Low Stock",
            returnPolicy: "30 days return policy",
            thumbnail: "...",
            price: 9.99,
            discountPercentage: 7.17,
            rating: 4.94,
            tags: ["beauty", "mascara"],
            images: ["...", "...", "..."],
            dimensions: Dimensions(width: 23.17, height: 14.43, depth: 28.01),
            reviews: [
                Review(rating: 2, comment: "Very unhappy with my purchase!", date: "2024-05-23T08:56:21.618Z", reviewerName: "John Doe", reviewerEmail: "john.doe@x.dummyjson.com"),
                Review(rating: 2, comment: "Not as described!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Nolan Gonzalez", reviewerEmail: "nolan.gonzalez@x.dummyjson.com"),
                Review(rating: 5, comment: "Very satisfied!", date: "2024-05-23T08:56:21.618Z", reviewerName: "Scarlett Wright", reviewerEmail: "scarlett.wright@x.dummyjson.com")
            ],
            meta: Meta(createdAt: "2024-05-23T08:56:21.618Z", updatedAt: "2024-05-23T08:56:21.618Z", barcode: "9164035109868", qrCode: "...")
        ),
        Product(
            id: 2,
            stock: 10,
            weight: 2,
            minimumOrderQuantity: 1,
            title: "Test Product",
            productDescription: "This is a test product.",
            category: "Test Category",
            sku: "12345",
            warrantyInformation: "1 year warranty",
            shippingInformation: "Ships in 1 week",
            availabilityStatus: "In Stock",
            returnPolicy: "30 days return policy",
            thumbnail: "https://example.com/thumbnail.jpg",
            price: 9.99,
            discountPercentage: 5.0,
            rating: 4.5,
            tags: ["test"],
            images: ["https://example.com/image.jpg"],
            dimensions: Product.Dimensions(width: 10.0, height: 10.0, depth: 10.0),
            reviews: [],
            meta: Product.Meta(createdAt: "2023-01-01", updatedAt: "2023-01-01", barcode: "123456789", qrCode: "")
        )
        
    ]
}
