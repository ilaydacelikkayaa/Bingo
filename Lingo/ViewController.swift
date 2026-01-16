//
//  ViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let engine = GameEngine(secretWord: "kitap", wordLength: 5)
          let prefill = engine.startRowPrefill()
          print(prefill)    }


}

