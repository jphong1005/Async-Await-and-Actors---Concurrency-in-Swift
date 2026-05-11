//
//  RandomImageListViewModel.swift
//  RandomQuoteAndImages
//
//  Created by 홍진표 on 5/11/26.
//

import Foundation
import Combine
import UIKit

@MainActor
final class RandomImageListViewModel: ObservableObject {
    @Published var randomImages: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async -> Void {
        do {
            let randomImages: [RandomImage] = try await WebServices.shared.getRandomImages(ids: ids)
            self.randomImages = randomImages.map({ RandomImageViewModel(randomImage: $0) })
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    let id: UUID = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        get { return UIImage(data: randomImage.image) }
    }
    
    var quote: String {
        get { return randomImage.randomQuote.quote }
    }
    
    var author: String {
        get { return randomImage.randomQuote.author }
    }
}
