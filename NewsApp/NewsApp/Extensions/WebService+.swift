//
//  WebService+.swift
//  NewsApp
//
//  Created by 홍진표 on 2/19/26.
//

import Foundation

extension WebService {
    
    func fetchSources(url: URL?) async throws -> [NewsSource] {
        guard let url: URL = url else { throw NetworkError.badUrl }
        
        do {
            let (data, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
            let newsSourceResponse: NewsSourceResponse? = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
            
            return newsSourceResponse?.sources ?? []
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetchNews(by sourceId: String, url: URL?) async throws -> [NewsArticle] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchNews(by: sourceId, url: url) { result in
                switch result {
                case .success(let newsArticles):
                    continuation.resume(returning: newsArticles)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
