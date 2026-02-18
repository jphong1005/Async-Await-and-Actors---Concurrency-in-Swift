//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by 홍진표 on 2/18/26.
//

import Foundation
import Combine

final class NewsArticleListViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticleViewModel] = []
    
    func getNewsBy(sourceId: String) -> Void {
        WebService.shared.fetchNews(by: sourceId, url: Constants.Urls.topHeadLines(by: sourceId)) { result in
            switch result {
            case .success(let newsArticles):
                DispatchQueue.main.async {
                    self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
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
