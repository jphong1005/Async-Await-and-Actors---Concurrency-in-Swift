//
//  ContentView.swift
//  NewsApp
//
//  Created by 홍진표 on 2/17/26.
//

import SwiftUI
import Combine

struct NewsSourceListView: View {
    //  @StateObject: View가 ObservableObject를 소유하고 관리
    //  특징: View가 처음 생성될 때, 객체를 초기화하고 그 View의 lifecycle에 따라 객체를 유지 (즉, View가 re-render 되어도 객체가 새로 생성되지 않고 유지됨)
    //
    // @ObservedObject: 외부에서 생성된 ObservableObject를 View에서 관찰
    //  특징: View가 소유하지 않으며, 외부에서 전달받은 객체를 관찰만 함 (즉, View가 re-reder 되면 객체가 재생성될 수도 있음)
    @StateObject private var newsSourceListViewModel: NewsSourceListViewModel = NewsSourceListViewModel()
    
    var body: some View {
        NavigationStack {
            List(newsSourceListViewModel.newsSources, id: \.id) { newsSource in
                NavigationLink {
                    NewsListView(newsSource: newsSource)
                } label: {
                    NewsSourceCell(newsSource: newsSource)
                }
            }
            .listStyle(.plain)
            .onAppear {
                newsSourceListViewModel.getSources()
            }
            .navigationTitle(Text("News Sources"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //  refresh the news
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
        }
    }
}

struct NewsSourceCell: View {
    
    let newsSource: NewsSourceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(verbatim: newsSource.name)
                .font(.headline)
            Text(verbatim: newsSource.description)
        }
    }
}

#Preview {
    NewsSourceListView()
}
