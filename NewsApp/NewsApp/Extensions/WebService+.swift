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
        guard let url: URL = url else { throw NetworkError.badUrl }
        
        do {
            let (data, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
            let newsArticleResponse: NewsArticleResponse? = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            
            return newsArticleResponse?.articles ?? []
        } catch {
            throw NetworkError.invalidData
        }
    }
}
