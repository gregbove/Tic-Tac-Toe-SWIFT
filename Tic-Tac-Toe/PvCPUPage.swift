//
//  PvCPUPage.swift
//  Tic-Tac-Toe
//

import SwiftUI

struct PvCPUPage: View {
    @State private var showPopUp: Bool = false
    @State private var gameOver: Bool = false
    @State private var tie: Bool = false 
    @State var turn = "X"
    @State var grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @State var c = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
    
    
    var body: some View {
        ZStack {
        VStack {
            Text("Player Versus CPU")
                .font(.system(size: 30))
            Text("Current: " + turn)
            Grid(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: false, cpuMode: true, abMode: true, randomMode: false)
            
            HStack {
                Button(action: {
                    for i in 0...8 {
                        grid[i] = " "
                    }
                    turn = "X"
                    c = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: sz, height: sz/2)
                        Text("Start Over")
                            .foregroundColor(.black)
                    }
                }
            }
        }
            if (tie) {
                PopUpWindow(title: "Tie", message: "Equal match", buttonText: "Play again!", gameOver: $gameOver, tie: $tie, grid: $grid, turn: $turn, col: $c)
            }
            else {
                PopUpWindow(title: "Winner: " + switchTurn(turn: turn) + "!", message: "Nice job :)", buttonText: "Play again!", gameOver: $gameOver, tie: $tie, grid: $grid, turn: $turn, col: $c)
            }
            
        }
    }
}

struct PvCPUPage_Previews: PreviewProvider {
    static var previews: some View {
        PvCPUPage()
    }
}
 
func minimax(board: [String], depth: Int, isMax: Bool) -> Int {
    var winner = "N"
    var score = 0
    var board_var = board
    
    if checkWin(arr: board) {
        winner = findWinner(arr: board)
    }
    
    if winner == "X" { 
        score = -10
    }
    if winner == "O" {
        score = 10
    }
    if winner == "No winner" {
        score = 0
    }
     
    if (score == 10) {
        return score - depth
    }
    if (score == -10) {
        return score + depth
    }
 
    if (isMovesLeft(board: board) == false) {
        return 0
    }
 
    if isMax {
        var best = -1000
 
        for i in 0...8 {
            if board_var[i] == " " {
                 
                board_var[i] = "O"
 
                if minimax(board: board_var, depth: depth + 1, isMax: (!isMax)) > best {
                    best = minimax(board: board_var, depth: depth + 1, isMax: (!isMax))
                }
 
                board_var[i] = " "
            }
        }
        return best
    }
 
    else {
        var best = 1000
        
        for i in 0...8 {
              
                if (board_var[i] == " ") {
                 
                    board_var[i] = "X"
                    
                    if (minimax(board: board_var, depth: depth + 1, isMax: (!isMax)) < best) {
                        best = minimax(board: board_var, depth: depth + 1, isMax: (!isMax))
                    }
                    board_var[i] = " "
                }
        }
        return best
    }
}

func findBestMove(board: [String]) -> Int {
    var bestVal = -1000
    var bestMove = -1
    var board_var = board
    var moveVal = -1000
 
    for i in 0...2 {
        for j in 0...2 {
            if (board_var[i*3+j] == " ") {
            
                board_var[i*3+j] = "O"
 
                moveVal = minimax(board: board_var, depth: 0, isMax: false)
 
                board_var[i*3+j] = " "
 
                if (bestVal < moveVal) {
                    bestMove = i*3+j
                    bestVal = moveVal
                }
            }
        }
    }
    return bestMove
}
