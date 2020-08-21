//
//  StartViewController.swift
//  CountDone
//
//  Created by 段欣寰 on 2020/8/22.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @objc func startTapped(_ sender: UIButton) {
        coordinator?.coordinateToTabBar()
    }
    
    // MARK: - Properties
    var coordinator: StartFlow?
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: -1, height: 3)
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

// MARK: - UI Setup
extension StartViewController {
    private func setupUI() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width / 3),
            startButton.heightAnchor
                .constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
}
