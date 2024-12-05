//
//  Product.swift
//  Shop
//
//  Created by Иван Толмачев on 03.12.2024.
//


import Foundation
import SwiftData

@Model
class Product: Identifiable, Codable {
    struct Dimensions: Codable {
        var width, height, depth: Double
    }

    struct Meta: Codable {
        var createdAt, updatedAt, barcode, qrCode: String
    }

    struct Review: Codable {
        var rating: Int
        var comment, date, reviewerName, reviewerEmail: String
    }

    @Attribute(.unique) var id: Int
    var stock: Int
    var weight: Int
    var minimumOrderQuantity: Int
    var title: String
    var productDescription: String // JSON Name description it due to NSObject property
    var category: String
    var brand: String
    var sku: String
    var warrantyInformation: String
    var shippingInformation: String
    var availabilityStatus: String
    var returnPolicy: String
    var thumbnail: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var tags: [String]
    var images: [String]
    var dimensions: Dimensions
    var reviews: [Review]
    var meta: Meta

    enum CodingKeys: String, CodingKey {
        case id, stock, weight, minimumOrderQuantity, title, category, brand, sku, warrantyInformation, shippingInformation, availabilityStatus, returnPolicy, thumbnail, price, discountPercentage, rating, tags, images, dimensions, reviews, meta
        case productDescription = "description"
    }

    init(id: Int, stock: Int, weight: Int, minimumOrderQuantity: Int, title: String, productDescription: String, category: String, brand: String = "Unknown Brand", sku: String, warrantyInformation: String, shippingInformation: String, availabilityStatus: String, returnPolicy: String, thumbnail: String, price: Double, discountPercentage: Double, rating: Double, tags: [String], images: [String], dimensions: Dimensions, reviews: [Review], meta: Meta) {
        self.id = id
        self.stock = stock
        self.weight = weight
        self.minimumOrderQuantity = minimumOrderQuantity
        self.title = title
        self.productDescription = productDescription
        self.category = category
        self.brand = brand
        self.sku = sku
        self.warrantyInformation = warrantyInformation
        self.shippingInformation = shippingInformation
        self.availabilityStatus = availabilityStatus
        self.returnPolicy = returnPolicy
        self.thumbnail = thumbnail
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.tags = tags
        self.images = images
        self.dimensions = dimensions
        self.reviews = reviews
        self.meta = meta
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        stock = try container.decode(Int.self, forKey: .stock)
        weight = try container.decode(Int.self, forKey: .weight)
        minimumOrderQuantity = try container.decode(Int.self, forKey: .minimumOrderQuantity)
        title = try container.decode(String.self, forKey: .title)
        productDescription = try container.decode(String.self, forKey: .productDescription)
        category = try container.decode(String.self, forKey: .category)
        brand = (try? container.decode(String.self, forKey: .brand)) ?? "Unknown Brand"
        sku = try container.decode(String.self, forKey: .sku)
        warrantyInformation = try container.decode(String.self, forKey: .warrantyInformation)
        shippingInformation = try container.decode(String.self, forKey: .shippingInformation)
        availabilityStatus = try container.decode(String.self, forKey: .availabilityStatus)
        returnPolicy = try container.decode(String.self, forKey: .returnPolicy)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        price = try container.decode(Double.self, forKey: .price)
        discountPercentage = try container.decode(Double.self, forKey: .discountPercentage)
        rating = try container.decode(Double.self, forKey: .rating)
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
        images = (try? container.decode([String].self, forKey: .images)) ?? []
        dimensions = try container.decode(Dimensions.self, forKey: .dimensions)
        reviews = try container.decode([Review].self, forKey: .reviews)
        meta = try container.decode(Meta.self, forKey: .meta)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(stock, forKey: .stock)
        try container.encode(weight, forKey: .weight)
        try container.encode(minimumOrderQuantity, forKey: .minimumOrderQuantity)
        try container.encode(title, forKey: .title)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(category, forKey: .category)
        try container.encode(brand, forKey: .brand)
        try container.encode(sku, forKey: .sku)
        try container.encode(warrantyInformation, forKey: .warrantyInformation)
        try container.encode(shippingInformation, forKey: .shippingInformation)
        try container.encode(availabilityStatus, forKey: .availabilityStatus)
        try container.encode(returnPolicy, forKey: .returnPolicy)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(price, forKey: .price)
        try container.encode(discountPercentage, forKey: .discountPercentage)
        try container.encode(rating, forKey: .rating)
        try container.encode(tags, forKey: .tags)
        try container.encode(images, forKey: .images)
        try container.encode(dimensions, forKey: .dimensions)
        try container.encode(reviews, forKey: .reviews)
        try container.encode(meta, forKey: .meta)
    }
    func copy() -> Product {
        return Product(
            id: id,
            stock: stock,
            weight: weight,
            minimumOrderQuantity: minimumOrderQuantity,
            title: title,
            productDescription: productDescription,
            category: category,
            brand: brand,
            sku: sku,
            warrantyInformation: warrantyInformation,
            shippingInformation: shippingInformation,
            availabilityStatus: availabilityStatus,
            returnPolicy: returnPolicy,
            thumbnail: thumbnail,
            price: price,
            discountPercentage: discountPercentage,
            rating: rating,
            tags: tags,
            images: images,
            dimensions: dimensions,
            reviews: reviews,
            meta: meta
        )
    }

}
