//
//  NewsListView.swift
//  NewsApp
//
//  Created by 홍진표 on 2/17/26.
//

import SwiftUI
import Combine

struct NewsListView: View {
    let newsSource: NewsSourceViewModel
    @StateObject private var newsArticleListViewModel: NewsArticleListViewModel = NewsArticleListViewModel()
    
    var body: some View {
        List(newsArticleListViewModel.newsArticles, id: \.id) { newsArticle in
            NewsArticleCell(newsArticle: newsArticle)
        }
        .listStyle(.plain)
        .task {
            await newsArticleListViewModel.getNewsBy(sourceId: newsSource.id)
        }
        .navigationTitle(newsSource.name)
    }
}

struct NewsArticleCell: View {
    
    let newsArticle: NewsArticleViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: newsArticle.urlToImage) { image in
                image.resizable()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(width: 100, height: 100)
            }
            
            VStack {
                Text(verbatim: newsArticle.title)
                    .fontWeight(.bold)
                Text(verbatim: newsArticle.description)
            }
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(newsSource: NewsSourceViewModel.default)
    }
}
