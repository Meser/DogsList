//
//  DogsListView.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import UIKit

final class DogsListView: UIViewController {
    // MARK: - UIElements
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        return view
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cellWidth = UIScreen.main.bounds.width * 0.99
        let cellHeight = UIScreen.main.bounds.height / 5
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.estimatedItemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColors.lightColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DogsCollectionViewCell.self, forCellWithReuseIdentifier: presenter?.cellId ?? "")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var presenter: DogsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    func setupViews() {
        title = "APP_TITLE".localized
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadData() {
        presenter?.getDogsList(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                switch result {
                case .success(_):
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.presenter?.presentError(message: error.localizedDescription)
                }
            }
        })
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        presenter?.deleteData()
        loadData()
    }
}

// MARK: - UICollectionViewDataSource
extension DogsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter?.cellId ?? "", for: indexPath) as? DogsCollectionViewCell
        cell?.setup(data: presenter?.dataSource[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension DogsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        presenter?.showDetails(for: presenter?.dataSource[indexPath.row])
    }
}
