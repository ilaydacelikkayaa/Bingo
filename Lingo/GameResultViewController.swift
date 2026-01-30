//
//  GameResultViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 23.01.2026.
//

import Foundation
import UIKit

class GameResultViewController: UIViewController {
    var onRestart: (() -> Void)?

    private let isWin: Bool
    private let answer: String
    
    private let cardView = UIView()
    private let stackView = UIStackView()

    private let wordTitleLabel=UILabel()
    private let titleLabel = UILabel()
    private let wordLabel = UILabel()
    private let meaningTitleLabel = UILabel()
    private let meaningLabel = UILabel()
    private let newGameButton = UIButton(type: .system)

    init(isWin: Bool, answer: String) {
        self.isWin = isWin
        self.answer = answer
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5) {
            self.cardView.transform = .identity
            self.cardView.alpha = 1
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.15
        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)
        cardView.layer.shadowRadius = 20
        cardView.layer.masksToBounds = false
        cardView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        cardView.alpha = 0
        
        view.addSubview(cardView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        cardView.addSubview(stackView)
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        newGameButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)

        if isWin{
            titleLabel.text="Tebrikler"
            cardView.layer.borderColor = UIColor.systemGreen.cgColor
            cardView.layer.borderWidth = 2

        }
        else{
            titleLabel.text="Kaybettin"
            cardView.layer.borderColor = UIColor.systemRed.cgColor
            cardView.layer.borderWidth = 2
        }
        stackView.addArrangedSubview(titleLabel)

        wordTitleLabel.text = "Doğru Kelime"
        wordTitleLabel.textAlignment = .center
        wordTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        wordTitleLabel.textColor = .secondaryLabel
        wordLabel.textAlignment = .center
        wordLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        wordLabel.textColor = .label
        wordLabel.text = answer.uppercased()
        stackView.addArrangedSubview(wordTitleLabel)
        stackView.addArrangedSubview(wordLabel)

        meaningTitleLabel.text = "Kelimenin Anlamı"
        meaningTitleLabel.textAlignment = .center
        meaningTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        meaningTitleLabel.textColor = .secondaryLabel

        meaningLabel.textAlignment = .center
        meaningLabel.font = .systemFont(ofSize: 16, weight: .regular)
        meaningLabel.textColor = .label
        meaningLabel.numberOfLines = 0
        meaningLabel.text = "Yükleniyor..." // API gelene kadar placeholder

        stackView.addArrangedSubview(meaningTitleLabel)
        stackView.addArrangedSubview(meaningLabel)

        stackView.addArrangedSubview(newGameButton)

        newGameButton.setTitle("Yeni Oyun", for: .normal)
        newGameButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        newGameButton.backgroundColor = .systemBlue
        newGameButton.setTitleColor(.white, for: .normal)
        newGameButton.layer.cornerRadius = 10
        newGameButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 300),
            cardView.heightAnchor.constraint(equalToConstant: 360),
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 24),
             stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
             stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
             stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        
        ])


    }
    @objc private func restartTapped() {
        dismiss(animated: true)
        onRestart?()
    }

}
