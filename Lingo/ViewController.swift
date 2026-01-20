//
//  ViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate { // UITextFieldDelegate protokolü, kullanıcı etkileşimlerini
    // yakalamak için kullanılan bir iletişim köprüsüdür.

    private let engine = GameEngine(secretWord: "kanun", wordLength: 5)
    private lazy var gridView = GridView(rows: engine.MaxAttempts, cols: engine.wordLength)
    private let guessTextField = UITextField()
    private var currentRow = 0
    private var currentCol = 0

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       guessTextField.becomeFirstResponder()
    }
    func textField(_ textField:UITextField , shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { //range değişim nerede string yeni basılan harf
        if string.isEmpty{
            print("Silme tuşu algılandı! CurrentCol: \(currentCol)")
            if currentCol>0{
                currentCol -= 1 //kullanıcı imlece bastıgında bi onceki sutuna gider silme fonk
                gridView.setCell(row: currentRow, col: currentCol, letter: nil)
                
            }
            return false
        }
        guard let char=string.lowercased().first else{return false}
        guard currentCol<engine.wordLength else{return false}
        gridView.setCell(row: currentRow, col: currentCol, letter: char)
        currentCol+=1
        return false
    

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        guessTextField.translatesAutoresizingMaskIntoConstraints = false
        guessTextField.borderStyle = .roundedRect
        guessTextField.autocapitalizationType = .none
        guessTextField.autocorrectionType = .no
        guessTextField.returnKeyType = .default
       guessTextField.alpha = 0.01

        view.addSubview(guessTextField)
        guessTextField.delegate=self


        gridView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            // GridView'ı ekranın üst kısmından (güvenli alan) 50 birim aşağıya koy
            gridView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            // Yatayda tam ortala
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Genişlik ve Yükseklik hesaplamaların doğru
            gridView.widthAnchor.constraint(equalToConstant: CGFloat(engine.wordLength) * 52 + CGFloat(engine.wordLength - 1) * 8),
            gridView.heightAnchor.constraint(equalToConstant: CGFloat(engine.MaxAttempts) * 52 + CGFloat(engine.MaxAttempts - 1) * 8),
            guessTextField.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 24),

            // Ekranın solundan ve sağından boşluk bırak
            guessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            guessTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            // Sabit yükseklik
            guessTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
      
  

    }


}

