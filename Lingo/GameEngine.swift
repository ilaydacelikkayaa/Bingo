//
//  GameEngine.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import Foundation
final class GameEngine{
    let wordLength:Int
    let MaxAttempts:Int=5
    private(set) var secretWord: String
    private(set) var attempts: [[LetterResult]] = []
    private(set) var lockedPrefixCount: Int = 1 //ilk harf
    init(secretWord:String,wordLength:Int){
        self.secretWord=secretWord.lowercased()
        self.wordLength=wordLength
    }
    func startRowPrefill()->String{
        let secretChars = Array(secretWord)
        let prefix = String(secretChars.prefix(lockedPrefixCount)) //lockedprefixcount kadar eleman almak
        let blanks=String(repeating: "_", count: wordLength - lockedPrefixCount)
        return prefix+blanks
    }
    func submit(guess:String)->[LetterResult]?{
        let guessLower = guess.lowercased()
        let guessChars = Array(guessLower)
        guard attempts.count<MaxAttempts else{return nil}
        guard guessChars.count == wordLength else { return nil }
        let secretChars = Array(secretWord)
        let lockedSecretPrefix = Array(secretChars.prefix(lockedPrefixCount))
        let lockedGuessPrefix = Array(guessChars.prefix(lockedPrefixCount))
        guard lockedGuessPrefix == lockedSecretPrefix else { return nil }

            // Şimdilik değerlendirme yok -> boş döndürelim (bir sonraki adımda dolduracağız)
            return []

    }
}
