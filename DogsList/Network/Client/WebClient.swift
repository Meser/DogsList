//
//  WebClient.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

struct endpoints {
    static let dogsList = "https://jsonblob.com/api/1151549092634943488"
}

final class WebClient {
    func fetchDogsList(completion: @escaping (Result<[Dog], Error>) -> Void) {
        if let url = URL(string: endpoints.dogsList) {
            Task {
                do {
                    let data = try await fetchData(url: url)
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Dog].self, from: data)
                    completion(.success(result))
                }
                catch {
                    return completion(.failure(self.generalError()))
                }
            }
        }
    }
    
    func fetchData(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func generalError() -> Error {
        return NSError(domain: "",
                       code: 401,
                       userInfo: [ NSLocalizedDescriptionKey: "There was an error fetching data"])
    }
}
