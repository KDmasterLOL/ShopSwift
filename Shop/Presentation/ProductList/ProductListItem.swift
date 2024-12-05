//
//  ProductListItem.swift
//  Shop
//
//  Created by Иван Толмачев on 03.12.2024.
//

import SwiftUI

struct ProductListItem: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
            Text(product.title)
                .font(.headline)
            Text(product.productDescription)
                .font(.subheadline)
            AsyncCachedImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            } placeholder: {
                ProgressView().frame(height: 100)
            }
        }
        .padding()
    }

}

#Preview {
    ProductListItem(product: Product.sample[0])
}
