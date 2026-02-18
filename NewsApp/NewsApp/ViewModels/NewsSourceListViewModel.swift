//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by 홍진표 on 2/17/26.
//

import Foundation
import Combine

//  ObservableObject: View와 Data를 bridge해주는 Protocol
final class NewsSourceListViewModel: ObservableObject {
    //  @Published: ObservableObject 안에서 View에게 상태 변화를 알릴 때 사용
    //  특징: class 타입에서 사용하며, 값이 바뀌면 @ObservedObject나 @StateObject가 구독하고 있는 View가 갱신됨
    @Published var newsSources: [NewsSourceViewModel] = []
    
    func getSources() -> Void {
        WebService.shared.fetchSources(url: Constants.Urls.sources) { result in
            switch result {
            case .success(let newsSources):
                DispatchQueue.main.async {
                    self.newsSources = newsSources.map(NewsSourceViewModel.init)
                    print(self.newsSources)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct NewsSourceViewModel {
    fileprivate var newsSource: NewsSource
    
    var id: String {
        get { return newsSource.id }
    }
    
    var name: String {
        get { return newsSource.name }
    }
    
    var description: String {
        get { return newsSource.description }
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC News")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
