//
//  ContentView.swift
//  UnstructuredTasks
//
//  Created by 홍진표 on 4/28/26.
//

import SwiftUI

struct ContentView: View {
    private func getData() async -> Void {
        //  Get the data
    }
    
    var body: some View {
        VStack {
            Button {
                //  Unstructured tasks: 동기 context 안에서 비동기 작업을 수행할 때 사용하거나 Task의 lifetime이 단일 scope 또는 단일 함수 범위 내에서 관리될 수 없는 경우에 사용
                //
                //  장점: 더 많은 유연성을 제공
                //  단점: 더 많은 수동 관리 필요
                Task { await getData() }
            } label: {
                Text(verbatim: "Get Data")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.teal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
