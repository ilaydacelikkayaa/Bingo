//
//  GameTypes.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 16.01.2026.
//

import Foundation
 enum LetterState{
    case correct
    case present
    case absent
    
}

struct LetterResult{
   let char: Character
    var state: LetterState
}
