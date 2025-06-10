//
//  DogsDetailPresenter.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

protocol DogsDetailPresenterProtocol: AnyObject { }

final class DogsDetailPresenter: DogsDetailPresenterProtocol {
    private weak var view: DogsDetailView?
    var interactor: DogsDetailInteractor?
    var router: DogsDetailRouter?
    var dog: Dog?
}
