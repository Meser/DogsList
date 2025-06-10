//
//  DogsListInteractor.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

protocol DogsListInteractorProtocol: AnyObject {
    func fetchDogs(completion: @escaping (Result<[Dog], Error>) -> Void)
    func save(list: [Dog])
    func getSavedList() -> [Dog]
    func deleteData()
}

final class DogsListInteractor {
    weak var presenter: DogsListPresenter?
}

// MARK: - DogsListInteractorProtocol
extension DogsListInteractor: DogsListInteractorProtocol {
    func getSavedList() -> [Dog] {
        guard let data = UserDefaults.standard.data(forKey: "List"),
              let savedList = try? JSONDecoder().decode([Dog].self, from: data) else { return [] }
        return savedList
    }
    
    func deleteData() {
        UserDefaults.standard.removeObject(forKey: "List")
    }
    
    func save(list: [Dog]) {
        do {
            let data = try JSONEncoder().encode(list)
            UserDefaults.standard.set(data, forKey: "List")
        } catch {
            print(error)
        }
    }
    
    func fetchDogs(completion: @escaping (Result<[Dog], any Error>) -> Void) {
        WebClient().fetchDogsList { result in
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
