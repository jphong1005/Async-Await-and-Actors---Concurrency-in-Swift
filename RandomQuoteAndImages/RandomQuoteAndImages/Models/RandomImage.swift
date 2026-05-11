//
//  RandomImage.swift
//  RandomQuoteAndImages
//
//  Created by 홍진표 on 5/11/26.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let randomQuote: RandomQuote
}

struct RandomQuote: Decodable {
    let quote: String
    let author: String
}
