//
//  ViewController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 05.03.2024.
//

import UIKit
import PagingCollectionViewLayout

final class ViewController: UIViewController {
    let marvelLogoImage: UIImageView = {
        let iV = UIImageView()
        iV.clipsToBounds = true
        iV.contentMode = .scaleAspectFill
        iV.image = UIImage(named: "marvel_logo")
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    let backgroundTriangleImage: UIImageView = {
        let iV = UIImageView()
        iV.clipsToBounds = true
        iV.contentMode = .scaleAspectFill
//        iV.image?.withRenderingMode(.alwaysTemplate)
        iV.image = UIImage(named: "triangle")
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    let chooseHeroLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your hero"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // - Paging collection view
    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let cellHeight = (3 / 5) * UIScreen.main.bounds.height
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    let colors: [UIColor] = [.red, .green, .blue, .purple, .orange, .black, .cyan]
    let images: [UIImage?] = [UIImage(named: "deadpool"), UIImage(named: "ironman"), UIImage(named: "spiderman"), UIImage(named: "ironman"), UIImage(named: "ironman"), UIImage(named: "ironman"), UIImage(named: "ironman")]
    let cellId = "cell id"
    lazy var collectionView: UICollectionView = {
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
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        view.addSubview(backgroundTriangleImage)
        view.addSubview(marvelLogoImage)
        view.addSubview(chooseHeroLabel)
        view.addSubview(collectionView)
//        backgroundTriangleImage.tintColor = .blue
        registerCollectionViewCells()
        setupConstraints()
    }
    
    func changeColorOfImage(image: UIImage, color: UIColor) -> UIImage? {
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

    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            marvelLogoImage.widthAnchor.constraint(equalToConstant: 120),
            marvelLogoImage.heightAnchor.constraint(equalToConstant: 25),
            marvelLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            marvelLogoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            
            chooseHeroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseHeroLabel.topAnchor.constraint(equalTo: marvelLogoImage.bottomAnchor, constant: 25),
            
            backgroundTriangleImage.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            backgroundTriangleImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundTriangleImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundTriangleImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: chooseHeroLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            
        ])
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - CollectionView Data Source

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let color = colors[indexPath.row]
        let image = images[indexPath.item]
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = cell.contentView.bounds
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        
        if let originalImage = UIImage(named: "triangle") {
            if let coloredImage = changeColorOfImage(image: originalImage, color: color) {
                 backgroundTriangleImage.image = coloredImage // Use the coloredImage as needed
            }
        }
        
        cell.contentView.addSubview(imageView)
        return cell
    }
}
