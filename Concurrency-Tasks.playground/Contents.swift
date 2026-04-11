import UIKit

enum NetworkError: Error {
    case badUrl
    case decodingError
    case invalidId
}

struct CreditScore: Decodable {
    let score: Int
}

struct Constants {
    struct Urls {
        static func experian(userId: Int) -> URL? {
            return URL(string: "http://localhost:3000/experian/credit-score/\(userId)")
        }
        
        static func equifax(userId: Int) -> URL? {
            return URL(string: "http://localhost:3000/equifax/credit-score/\(userId)")
        }
    }
}

func calculateAPR(creditScores: [CreditScore]) -> Double {
    let sum: Int = creditScores.reduce(0) { next, credit in
        return next + credit.score
    }
    
    return Double((sum / creditScores.count) / 100)
}

func getAPR(userId: Int) async throws -> Double {
    guard let experianUrl: URL = Constants.Urls.experian(userId: userId),
          let equifaxUrl: URL = Constants.Urls.equifax(userId: userId) else {
        throw NetworkError.badUrl
    }
    
    async let (experianData, _): (Data, URLResponse) = URLSession.shared.data(from: experianUrl)
    async let (equifaxData, _): (Data, URLResponse) = URLSession.shared.data(from: equifaxUrl)
    
    let experianCreditScore: CreditScore? = try? JSONDecoder().decode(CreditScore.self, from: try await experianData)
    let equifaxCreditScore: CreditScore? = try? JSONDecoder().decode(CreditScore.self, from: try await equifaxData)
    
    guard let experianCreditScore: CreditScore = experianCreditScore,
          let equifaxCreditScore: CreditScore = equifaxCreditScore else {
        throw NetworkError.decodingError
    }
    
    return calculateAPR(creditScores: [experianCreditScore, equifaxCreditScore])
}

let ids: [Int] = Array(1...5)

func getAPRForAllUsers(ids: [Int]) async throws -> [Int : Double] {
    var userAPR: [Int : Double] = [:]
    
    try await withThrowingTaskGroup(of: (Int, Double).self) { group in
        for id in ids {
            group.addTask {
                return (id, try await getAPR(userId: id))
            }
        }
        
        for try await (id, apr) in group {
            userAPR[id] = apr
        }
    }
    
    return userAPR
}

Task {
    let userAPRs = try await getAPRForAllUsers(ids: ids)
    print("userAPRs: \(userAPRs)")
}
