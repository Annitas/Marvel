//
//  ViewController.swift
//  MarvelHero
//
//  Created by Anita Stashevskaya on 05.03.2024.
//

import UIKit

final class ViewController: UIViewController, UICollectionViewDelegate {
    private let mainHeroView = MarvelHeroView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        view.addSubview(mainHeroView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainHeroView.topAnchor.constraint(equalTo: view.topAnchor),
            mainHeroView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainHeroView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainHeroView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}
