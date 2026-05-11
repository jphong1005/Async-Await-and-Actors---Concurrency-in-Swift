//
//  ContentView.swift
//  RandomQuoteAndImages
//
//  Created by 홍진표 on 5/10/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var randomImageListVM: RandomImageListViewModel = RandomImageListViewModel()
    
    var body: some View {
        List(randomImageListVM.randomImages) { randomImage in
            HStack {
                randomImage.image.map {
                    Image(uiImage: $0)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                VStack(alignment: .leading) {
                    Text(verbatim: "\"\(randomImage.quote)\"\n")
                    Text(verbatim: "- \(randomImage.author)")
                }
            }
        }
        .task {
            await randomImageListVM.getRandomImages(ids: Array(100...120))
        }
    }
}

#Preview {
    ContentView()
}
