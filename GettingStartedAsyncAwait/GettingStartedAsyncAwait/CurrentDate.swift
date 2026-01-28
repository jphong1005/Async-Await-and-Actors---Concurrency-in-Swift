//
//  CurrentDate.swift
//  GettingStartedAsyncAwait
//
//  Created by 홍진표 on 1/28/26.
//

import Foundation

//  https://ember-sparkly-rule.glitch.me/current-date => Glitch servers shutdown
//
//  { "datetime": "yyyy-MM-dd'T'HH:mm:ss+09:00" }
struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let dateTime: String
    
    private enum CodingKeys: String, CodingKey {
        case dateTime = "datetime"
    }
}
