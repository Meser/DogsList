//
//  DogsListPresenter.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

protocol DogsListPresenterProtocol: AnyObject {
    func getDogsList(completion: @escaping (Result<[Dog], Error>) -> Void)
    func presentError(message: String)
    func showDetails(for dog: Dog?)
    func save(list: [Dog])
    func getSavedList() -> [Dog]
    func deleteData()
}

final class DogsListPresenter {
    private weak var view: DogsListView?
    var interactor: DogsListInteractor?
    var router: DogsListRouter?
    var dataSource: [Dog] = []
    let cellId = "dogsCellId"
}

// MARK: - DogsListPresenterProtocol
extension DogsListPresenter: DogsListPresenterProtocol {
    func getSavedList() -> [Dog] {
        interactor?.getSavedList() ?? []
    }
    
    func save(list: [Dog]) {
        interactor?.save(list: list)
    }
    
    func deleteData() {
        interactor?.deleteData()
    }
    
    func showDetails(for dog: Dog?) {
        router?.showDetails(for: dog)
    }
    
    func presentError(message: String) {
        router?.presentError(message: message)
    }
    
    func getDogsList(completion: @escaping (Result<[Dog], any Error>) -> Void) {
        if getSavedList().isEmpty {
            interactor?.fetchDogs(completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let list):
                    self.dataSource = list
                    self.save(list: list)
                    completion(.success(list))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } else {
            self.dataSource = getSavedList()
            completion(.success(self.dataSource))
        }
    }
}
