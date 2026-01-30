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
    private let topBar = GameTopBarView()
    
    private func startNewRow() {
        let firstChar = Array(engine.secretWord)[0]
        currentGuess = String(firstChar)
        currentCol = 1
        gridView.setCell(row: currentRow, col: 0, letter: firstChar)
    }
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 20/255, green: 30/255, blue: 60/255, alpha: 1).cgColor,
            UIColor(red: 10/255, green: 15/255, blue: 35/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds

        view.layer.insertSublayer(gradient, at: 0)
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
        resultVC.onRestart = { [weak self] in
            self?.restartGame()
        }

    }
    private func restartGame() {
        currentRow = 0
        currentCol = 0
        currentGuess = ""
        currentState = .playing

      

        clearGridUI()
        startNewRow()
    }
    private func clearGridUI() {
        gridView.clear()
    }

    
    override func viewDidLoad() {
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        super.viewDidLoad()
        setupBackground()

      
        
        view.backgroundColor = .systemBackground
        guessTextField.translatesAutoresizingMaskIntoConstraints = false
        guessTextField.borderStyle = .roundedRect
        guessTextField.autocapitalizationType = .none
        guessTextField.autocorrectionType = .no
        guessTextField.returnKeyType = .default
       guessTextField.alpha = 0.01

        view.addSubview(guessTextField)
        guessTextField.delegate=self

        
        view.addSubview(topBar)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16), //üst bar
            topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),//sag sol
            topBar.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:0.9), //genislik
             topBar.heightAnchor.constraint(equalToConstant: 56), //Yukseklik
                    
                    gridView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 24),
                    gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    gridView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9), // Ekranın %90'ı
                    gridView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            gridView.heightAnchor.constraint(equalToConstant: 400),
                
                gridView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                
            
        ])
      
       startNewRow()

    }
  


}

