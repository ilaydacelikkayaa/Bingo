//
//  ViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import UIKit

class ViewController: UIViewController {

    private let engine = GameEngine(secretWord: "kanun", wordLength: 5)
    private lazy var gridView = GridView(rows: engine.MaxAttempts, cols: engine.wordLength)


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
      
       
      
        gridView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            // GridView'ı ekranın üst kısmından (güvenli alan) 50 birim aşağıya koy
            gridView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            // Yatayda tam ortala
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Genişlik ve Yükseklik hesaplamaların doğru
            gridView.widthAnchor.constraint(equalToConstant: CGFloat(engine.wordLength) * 52 + CGFloat(engine.wordLength - 1) * 8),
            gridView.heightAnchor.constraint(equalToConstant: CGFloat(engine.MaxAttempts) * 52 + CGFloat(engine.MaxAttempts - 1) * 8)
        ])
        if let result = engine.submit(guess: "kuran") {
            gridView.setResultRow(0, results: result.results)
        }


    }


}

