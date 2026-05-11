//
//  Constants.swift
//  RandomQuoteAndImages
//
//  Created by 홍진표 on 5/11/26.
//

import Foundation

struct Constants {
    struct Urls {
        static func getRandomImageUrl() -> URL? {
            return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuotesUrl: URL? = URL(string: "https://dummyjson.com/quotes/random")
    }
}
