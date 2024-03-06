//
//  MarvelHeroView.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 06.03.2024.
//

import UIKit
import PagingCollectionViewLayout

final class MarvelHeroView: UIView, UICollectionViewDelegate {
    private let backgroundTriangleImage: UIImageView = {
        let iV = UIImageView()
        iV.clipsToBounds = true
        iV.contentMode = .scaleAspectFill
        iV.image = UIImage(named: "triangle")
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    private let marvelLogoImage: UIImageView = {
        let iV = UIImageView()
        iV.clipsToBounds = true
        iV.contentMode = .scaleAspectFill
        iV.image = UIImage(named: "marvel_logo")
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    private let chooseHeroLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your hero"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // -  MARK: Paging collection view
    private let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    private let cellHeight = (3 / 5) * UIScreen.main.bounds.height
    private let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    private let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    private let colors: [UIColor] = [.red, .green, .blue, .purple, .orange, .black, .cyan]
    
    private let images: [UIImage?] = [UIImage(named: "deadpool"), UIImage(named: "ironman"), UIImage(named: "spiderman"), UIImage(named: "ironman"), UIImage(named: "ironman"), UIImage(named: "ironman"), UIImage(named: "ironman")]
    private let heroNames: [String] = ["Kek", "Lol", "Pepe", "Pepa", "Puff", "No", "Name"]
    
    private let cellId = "cell id"
    private lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MarvelHeroCollectionViewCell.self, forCellWithReuseIdentifier: MarvelHeroCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundTriangleImage)
        addSubview(marvelLogoImage)
        addSubview(chooseHeroLabel)
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            marvelLogoImage.widthAnchor.constraint(equalToConstant: 120),
            marvelLogoImage.heightAnchor.constraint(equalToConstant: 25),
            marvelLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            marvelLogoImage.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            
            chooseHeroLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            chooseHeroLabel.topAnchor.constraint(equalTo: marvelLogoImage.bottomAnchor, constant: 25),
            
            collectionView.topAnchor.constraint(equalTo: chooseHeroLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            
            backgroundTriangleImage.topAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            backgroundTriangleImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundTriangleImage.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundTriangleImage.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    private func changeColorOfImage(image: UIImage, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), blendMode: .destinationIn, alpha: 1.0)
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage
    }
}


extension MarvelHeroView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelHeroCollectionViewCell.cellIdentifier, for: indexPath)  as! MarvelHeroCollectionViewCell
        
        cell.update(heroName: heroNames[indexPath.row], image: images[indexPath.item])
        
        if let originalImage = UIImage(named: "triangle") {
            if let coloredImage = changeColorOfImage(image: originalImage, color: colors[indexPath.row]) {
                backgroundTriangleImage.image = coloredImage
            }
        }
        
        return cell
    }
}
