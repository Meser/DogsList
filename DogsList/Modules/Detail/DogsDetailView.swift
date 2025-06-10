//
//  DogsDetailView.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import UIKit

class DogsDetailView: UIViewController {
    // MARK: - UIElements
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 6
        return view
    }()
    private lazy var dogInformation: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.textColor = AppColors.lightColor
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var presenter: DogsDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    func setupViews() {
        view.addSubview(imageView)
        view.addSubview(dogInformation)
        view.backgroundColor = AppColors.lightColor
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height / 8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dogInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dogInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dogInformation.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    func setupData() {
        title = String(format: "DOG_NAME".localized, presenter?.dog?.dogName ?? "")
        if let url = URL(string: presenter?.dog?.image ?? "") { imageView.load(url: url) }
        dogInformation.text = presenter?.dog?.description
    }
    
}
