//
//  GameResultViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 23.01.2026.
//

import Foundation
import UIKit

class GameResultViewController: UIViewController {
    private let isWin: Bool
    private let answer: String

    init(isWin: Bool, answer: String) {
        self.isWin = isWin
        self.answer = answer
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
