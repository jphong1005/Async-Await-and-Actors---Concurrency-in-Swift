//
//  Constants.swift
//  NewsApp
//
//  Created by 홍진표 on 2/17/26.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let sources: URL? = URL(string: "https://newsapi.org/v2/top-headlines/sources?apiKey=(API_KEY)")
        
        static func topHeadLines(by source: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=(API_KEY)")
        }
    }
}
