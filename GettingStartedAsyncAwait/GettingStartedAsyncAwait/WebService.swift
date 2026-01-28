//
//  WebService.swift
//  GettingStartedAsyncAwait
//
//  Created by 홍진표 on 1/28/26.
//

import Foundation

class WebService {
    
    func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "https://mocki.io/v1/c60c7d72-74f8-4080-9672-312cae14eb53") else {
            fatalError("URL is incorrect!")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
}
