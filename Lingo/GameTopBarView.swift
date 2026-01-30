//
//  GameTopBarView.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 24.01.2026.
//

import Foundation
import UIKit
final class GameTopBarView: UIView{
    private let backButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)

    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
  
    }
    required override init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        layer.cornerRadius = 20 //layer çizim işlerini yapar
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 12


        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        
        backButton.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        backButton.layer.cornerRadius = 16
        backButton.clipsToBounds = true

        resetButton.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        resetButton.layer.cornerRadius = 16
        resetButton.clipsToBounds = true

        
        titleLabel.text = "BINGO"
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        resetButton.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        resetButton.tintColor = .white
    }
    private func setupLayout() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            resetButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: 32),
            resetButton.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }


}

