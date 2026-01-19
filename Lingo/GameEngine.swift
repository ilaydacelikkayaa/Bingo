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
    var attemptsLeft: Int {
        return MaxAttempts - attempts.count
    }
    var isSolved:Bool{
        guard let lastAttempt=attempts.last else {return false}
        return lastAttempt.allSatisfy{ $0.state == .correct}
    }
    private(set) var secretWord: String
    private(set) var attempts: [[LetterResult]] = []
    private(set) var lockedLetters:[Character?]
    init(secretWord:String,wordLength:Int){
        self.secretWord=secretWord.lowercased()
        self.wordLength=wordLength
        self.lockedLetters=Array(repeating: nil, count: wordLength) //tüm kutucukları nil olan bir dizi oluştur
        let chars=Array(self.secretWord)
        if !chars.isEmpty{
            self.lockedLetters[0]=chars[0]
        }
        
    }
    func startRowPrefill()->String{
        var outputs=""
        for i in 0..<wordLength{
            if let char=lockedLetters[i]{
                outputs.append(char)
            }else{
                outputs.append("_ ")
            }
        }
        return outputs
    }
    func submit(guess:String)->(results : [LetterResult],nextHit:String)?{
        let guessLower = guess.lowercased()
        let guessChars = Array(guessLower)
        guard attempts.count<MaxAttempts else{return nil}
        guard guessChars.count == wordLength else { return nil }
        let secretChars = Array(secretWord)
        for i in 0..<wordLength{
            if let lockedChar=lockedLetters[i]{
                if guessChars[i] != lockedChar{
                    return nil
                }
            }
        }
        let eval=evaluate(guess: guessChars, secret: secretChars)
        for i in 0..<wordLength{
            if eval[i].state == .correct{
                lockedLetters[i] = eval[i].char
            }
        }
        attempts.append(eval)
        let nextHit = startRowPrefill()
        return (eval,nextHit)
        
        
    }
    //değerlendirme
    private func evaluate(guess:[Character],secret:[Character])->[LetterResult]{
        var results = Array(repeating:LetterResult(char: " ", state: .absent),count:wordLength)
        var remainingCounts:[Character:Int]=[:]
        for i in 0..<wordLength{
            let g=guess[i]
            let s=secret[i]
            if g==s{
                results[i]=LetterResult(char: g, state: .correct)
            }else{
                results[i]=LetterResult(char: g, state: .absent)
                remainingCounts[s, default: 0]+=1
            }
        }
        for i in 0..<wordLength{
            if results[i].state == .correct{continue}
            let g=guess[i]
            if let count=remainingCounts[g],count>0{
                results[i]=LetterResult(char: g, state: .present)
                remainingCounts[g]=count-1
                
            }else{
                results[i]=LetterResult(char: g, state: .absent)
            }
        }
        return results
    }
    
}
