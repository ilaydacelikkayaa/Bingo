//
//  GridView.swift
//  Lingo
//
//  Created by İlayda Çelikkaya on 19.01.2026.
//

import Foundation
import UIKit
final class GridView: UIView {
    
    private let rows: Int
    private let cols: Int
    private let outerStack = UIStackView()
    private var cells: [[LetterCellView]] = []
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        super.init(frame: .zero)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp(){
        outerStack.translatesAutoresizingMaskIntoConstraints = false
        outerStack.axis = .vertical
        outerStack.alignment = .fill
        outerStack.distribution = .fillEqually
        outerStack.spacing = 8
        addSubview(outerStack)
        NSLayoutConstraint.activate([
            outerStack.topAnchor.constraint(equalTo: topAnchor),
            outerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        buildGrid()
        
    }
    func clear() {
        for row in 0..<rows {
            for col in 0..<cols {
                cells[row][col].setLetter(nil)
                cells[row][col].resetAppearance()
            }
        }
    }
 
    private func buildGrid(){
        for _ in 0..<rows{
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            rowStack.spacing = 8
            var rowCells:[LetterCellView]=[]
            for _ in 0..<cols {
                let cell = LetterCellView()
                rowStack.addArrangedSubview(cell)
                rowCells.append(cell)
            }
            outerStack.addArrangedSubview(rowStack)
            cells.append(rowCells)
            
        }
    }
        func setCell(row:Int,col:Int,letter:Character?){ //tek bir kutuyla ilgilenir
            guard row>=0, row<rows,col>=0,col<cols else {return}
            cells[row][col].setLetter(letter)
        }
        func setRow(_ row:Int,text:String){
            let chars = Array(text)
            for col in 0..<cols {
                var letter:Character? = nil
                if col<chars.count{
                    if chars[col] != "_" {
                        letter = chars[col]
                    }
                    setCell(row: row, col: col, letter: letter)
                    
                    
                }
            }
        }
        func setResultRow(_ row:Int,results:[LetterResult]){ //row hangi satırı boyayacağım
            guard row>=0, row<rows else {return}
            for col in 0..<cols{
                let cell=cells[row][col]
                let result=results[col]
                cell.setLetter(result.char)
                cell.setState(result.state)

            }
        }
    
    
}
