//
//  LetterCellView.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 19.01.2026.
//

import Foundation
import UIKit
final class LetterCellView: UIView{
    private let label=UILabel()
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //storyboard kullanılmayacak
    }
    private func setup() {
        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor // Çerçeve rengi açık gri
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor), //yatayda tam orta
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func setLetter (_ char:Character?){
        if let char {
            label.text = String(char).uppercased()
        }
        else {
            label.text = ""
        }
        
    }
    func setState(_ state:LetterState){
        switch state{
        case .correct:
            backgroundColor = UIColor.systemGreen
            layer.borderColor = UIColor.systemGreen.cgColor
        case .present:
            backgroundColor = UIColor.systemOrange
            layer.borderColor = UIColor.systemOrange.cgColor
        case .absent:
            backgroundColor=UIColor.systemGray4
            layer.borderColor = UIColor.systemGray4.cgColor
        }
        //bu fonksiyon hücrenin görünümünü letterstate e gore günceller
    }
}
