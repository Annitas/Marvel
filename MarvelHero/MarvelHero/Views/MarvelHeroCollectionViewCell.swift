//
//  MarvelHeroCollectionViewCell.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 06.03.2024.
//

import UIKit

final class MarvelHeroCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        addConstraints()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.shadowOpacity = 0.3
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func update(heroName: String, image: UIImage?) {
        imageView.image = image
        nameLabel.text = heroName
    }
}
