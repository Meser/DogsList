//
//  DogsDetailInteractor.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation

protocol DogsDetailInteractorProtocol: AnyObject { }

final class DogsDetailInteractor: DogsDetailInteractorProtocol {
    weak var presenter: DogsDetailPresenter?
}
