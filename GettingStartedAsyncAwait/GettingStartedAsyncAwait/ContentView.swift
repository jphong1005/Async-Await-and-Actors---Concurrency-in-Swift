//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by 홍진표 on 1/1/26.
//

import SwiftUI

//  https://ember-sparkly-rule.glitch.me/current-date => Glitch servers shutdown
//
//  { "datetime": "yyyy-MM-dd'T'HH:mm:ss+09:00" }
struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let dateTime: String
    
    private enum CodingKeys: String, CodingKey {
        case dateTime = "datetime"
    }
}

struct ContentView: View {
    @State private var currentDates: [CurrentDate] = []
    
    private func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "https://mocki.io/v1/c60c7d72-74f8-4080-9672-312cae14eb53") else {
            fatalError("URL is incorrect!")
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
    private func populateDates() async -> Void {
        do {
            guard let currentDate = try await getDate() else {
                return
            }
            self.currentDates.append(currentDate)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(currentDates) { currentDate in
                Text(verbatim: "\(currentDate.dateTime)")
            }
            .listStyle(.plain)
            .navigationTitle("Dates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await populateDates()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
            .task {
                await populateDates()
            }
        }
    }
}

#Preview {
    ContentView()
}
