//
//  ViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import UIKit

class ViewController: UIViewController {

    private let engine = GameEngine(secretWord: "kanun", wordLength: 5)
    private let hintLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.font = .systemFont(ofSize: 36, weight: .bold)
        hintLabel.textAlignment = .center
        hintLabel.text = engine.startRowPrefill()
        view.addSubview(hintLabel)
        NSLayoutConstraint.activate([
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])


    }


}

