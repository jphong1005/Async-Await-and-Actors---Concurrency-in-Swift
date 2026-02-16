import UIKit

struct Post: Decodable {
    let title: String
}

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

//  @Sendable: 동시성 (Concurrency) 환경에서 안전하게 실행할 수 있는 closure임을 보장하는 Annotation
//  즉, "스레드 안전성 (Thread Safe)"을 보장하기 위해 closure가 외부 상태를 안전하게 참조하도록 제한하는 표시
//
//  외부 클로저가 다른 스레드에서 실행될 때, 그 클로저가 캡처한 공유 가변 상태 (shared mutable state)에 동기화 없이 접근하면 '데이터 경쟁 (Data Race)'이 발생할 수 있음
private func getPosts(completion: @escaping @Sendable (Result<[Post], NetworkError>) -> Void) -> Void {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            completion(.failure(.noData))
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        completion(.success(posts ?? []))
    }.resume()
}

func getPosts() async throws -> [Post] {
    return try await withCheckedThrowingContinuation { continuation in
        getPosts { result in
            switch result {
            case .success(let posts):
                continuation.resume(returning: posts)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}

Task {
    do {
        let posts = try await getPosts()
        print(posts)
    } catch {
        print(error)
    }
}
