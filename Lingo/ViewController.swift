//
//  ViewController.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import UIKit
enum GameState {
    case playing
    case won
    case lost
}

class ViewController: UIViewController,UITextFieldDelegate { // UITextFieldDelegate protokolü, kullanıcı etkileşimlerini
    // yakalamak için kullanılan bir iletişim köprüsüdür.

    private let engine = GameEngine(secretWord: "kanun", wordLength: 5)
    private lazy var gridView = GridView(rows: engine.MaxAttempts, cols: engine.wordLength)
    private let guessTextField = UITextField()
    private var currentRow = 0
    private var currentCol = 0
    private var currentGuess = ""
    private var currentState: GameState = .playing
    
    private func startNewRow() {
        let firstChar = Array(engine.secretWord)[0]
        currentGuess = String(firstChar)
        currentCol = 1
        gridView.setCell(row: currentRow, col: 0, letter: firstChar)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       guessTextField.becomeFirstResponder()
    }
    func textField(_ textField:UITextField , shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { //range değişim nerede string yeni basılan harf
        textField.text = " " //içeride silinecek bir şey var diyorum
        if currentState != .playing {
            return false
        }

        if string == "\n" && currentGuess.count < engine.wordLength {
            // Satır bitmedi, aynı satırda devam
            currentCol = currentGuess.count
            return false
        }

        if string == "\n" &&  currentGuess.count == engine.wordLength {
            print("Return tuşuna basıldı, kelime:",currentGuess)
            if let results = engine.submit(guess: currentGuess){
                gridView.setResultRow(currentRow, results: results)
                if currentGuess.lowercased() == engine.secretWord.lowercased(){
                    currentState = .won
                    showGameResult()
                    return false
                }
                if currentRow == engine.MaxAttempts - 1 {
                    currentState = .lost
                    showGameResult()
                    return false
                }

                currentRow += 1
               startNewRow()
          
            }
            
            return false
        }
        
        if string.isEmpty{
            guard currentGuess.count>1 else { return false}
            print("Silme denendi. Mevcut kelime: \(currentGuess)")
            guard !currentGuess.isEmpty else{return false}
            currentGuess.removeLast()
            currentCol=currentGuess.count
            
                gridView.setCell(row: currentRow, col: currentCol, letter: nil)
                
            
            return false
        }

        guard let char = string.uppercased(with: Locale(identifier: "tr")).first else{return false}
        guard currentGuess.count<engine.wordLength else{return false}
        currentCol=currentGuess.count
        currentGuess.append(char) // State'e (hafızaya) ekle
        gridView.setCell(row: currentRow, col: currentCol, letter: char)
        print("Eklenen harf: \(char), Yeni kelime: \(currentGuess)")
        return false
    

    }
    private func showGameResult(){
        let resultVC=GameResultViewController(
            isWin: currentState == .won,
            answer: engine.secretWord

        )
        resultVC.modalPresentationStyle = .overFullScreen
         present(resultVC, animated: true)
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
      
       startNewRow()

    }


}

