//
//  DogsDetailRouter.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation
import UIKit

protocol DogsDetailRouterProtocol { }

final class DogsDetailRouter: DogsDetailRouterProtocol {
    private(set) weak var view: DogsDetailView?
    static func createModule(for dog: Dog?) -> DogsDetailView {
        let presenter = DogsDetailPresenter()
        let view = DogsDetailView()
        let interactor = DogsDetailInteractor()
        let router = DogsDetailRouter()
        view.presenter = presenter
        view.presenter?.dog = dog
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.router = router
        view.presenter?.router?.view = view
        return view
    }
}
