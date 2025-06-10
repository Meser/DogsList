//
//  DogsListRouter.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import Foundation
import UIKit

protocol DogsListRouterProtocol {
    func presentError(message: String)
    func showDetails(for dog: Dog?)
}

final class DogsListRouter {
    private(set) weak var view: DogsListView?
    
    static func createModule() -> DogsListView {
        let presenter = DogsListPresenter()
        let view = DogsListView()
        let interactor = DogsListInteractor()
        let router = DogsListRouter()
        
        view.presenter = presenter
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.router = router
        view.presenter?.router?.view = view
        
        return view
    }
}

// MARK: - DogsListRouterProtocol
extension DogsListRouter: DogsListRouterProtocol {
    func showDetails(for dog: Dog?) {
        view?.navigationController?.pushViewController(DogsDetailRouter.createModule(for: dog), animated: true)
    }
    
    func presentError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Aceptar", style: .default) { (_) in }
        alertController.addAction(dismissAction)
        DispatchQueue.main.async {
            self.view?.navigationController?.present(alertController, animated: true)
        }
    }
}
