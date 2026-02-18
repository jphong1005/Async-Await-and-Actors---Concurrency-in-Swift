//
//  NewsSource.swift
//  NewsApp
//
//  Created by 홍진표 on 2/17/26.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
