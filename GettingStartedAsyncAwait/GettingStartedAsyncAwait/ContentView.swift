//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by 홍진표 on 1/1/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var currentDateListVM = CurrentDateListViewModel()
    
    var body: some View {
        NavigationStack {
            List(currentDateListVM.currentDates, id: \.id) { currentDate in
                Text(verbatim: "\(currentDate.date)")
            }
            .listStyle(.plain)
            .navigationTitle("Dates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await currentDateListVM.populateDates()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
            .task {
                await currentDateListVM.populateDates()
            }
        }
    }
}

#Preview {
    ContentView()
}
