//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by 홍진표 on 2/18/26.
//

import Foundation
import Combine

//  @MainActor: UI에 관여하는 것들(Type, Method, Property)을 항상 Main Thread에서 실행하도록 보장하는 Annotation (즉, Main Thread에 격리(isolated))
//  특징: DispatchQueue.main.async를 사용하지 않아도 됨
@MainActor
final class NewsArticleListViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticleViewModel] = []
        
    func getNewsBy(sourceId: String) async -> Void {
        do {
            let newsArticle: [NewsArticle] = try await WebService.shared.fetchNews(by: sourceId, url: Constants.Urls.topHeadLines(by: sourceId))
            self.newsArticles = newsArticle.map(NewsArticleViewModel.init)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NewsArticleViewModel {
    let id: UUID = UUID()
    fileprivate let newsArticle: NewsArticle
    
    var author: String {
        get { return newsArticle.author ?? "" }
    }
    
    var title: String {
        get { return newsArticle.title ?? "" }
    }
    
    var description: String {
        get { return newsArticle.description ?? "" }
    }
    
    var urlToImage: URL? {
        get { return URL(string: newsArticle.urlToImage ?? "") }
    }
}
