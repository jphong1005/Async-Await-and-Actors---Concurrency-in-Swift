//
//  ContentView.swift
//  DownloadingImages
//
//  Created by 홍진표 on 1/1/26.
//

import SwiftUI

struct ContentView: View {
    private func downloadImage() -> Void {
        guard let imageURL = URL(string: "https://picsum.photos/200/300") else { return }
        
        DispatchQueue.global().async {
            //  Concurrent의 특성을 이용하여
            //  Background-Thread에서 Image를 download
            let _ = try? Data(contentsOf: imageURL)
            
            DispatchQueue.main.async {
                // UI 업데이트
            }
        }
    }
    
    var body: some View {
        VStack {
            List(1...20, id: \.self) { index in
                Text(verbatim: "\(index)")
            }
            
            Button {
                //  Event Handler 호출
                downloadImage()
            } label: {
                Label("Download Image", systemImage: "arrow.down")
                    .tint(.teal)
            }
        }
    }
}

#Preview {
    ContentView()
}
