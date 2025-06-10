//
//  DogsCollectionViewCell.swift
//  DogsList
//
//  Created by Juan Hernandez Galvan on 09/06/25.
//

import UIKit

class DogsCollectionViewCell: UICollectionViewCell {
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
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textColor = AppColors.darkColor
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var content: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        view.textColor = AppColors.grayColor
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var age: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        view.textColor = AppColors.darkColor
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        LayoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func LayoutUI() {
        addSubview(imageView)
        addSubview(containerView)
        containerView.addSubview(title)
        containerView.addSubview(content)
        containerView.addSubview(age)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/5),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            content.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/1.7),
            
            age.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            age.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setup(data: Dog?) {
        if let url = URL(string: data?.image ?? "") { imageView.load(url: url) }
        title.text = data?.dogName
        content.text = data?.description
        age.text = String(format: "DOG_YEARS".localized, data?.age ?? 0)
    }
}
