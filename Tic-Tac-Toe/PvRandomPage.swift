//
//  PvRandomPage.swift
//  Tic-Tac-Toe
//

import SwiftUI

struct PvRandomPage: View {
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
            Grid(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: false, cpuMode: true, abMode: false, randomMode: true)
            
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

struct PvRandomPage_Previews: PreviewProvider {
    static var previews: some View {
        PvRandomPage()
    }
}

 
func findBestMoveRandom(board: [String]) -> Int { 
    var spot = Int.random(in: 0...8)
    
    while board[spot] != " " {
        spot = Int.random(in: 0...8)
    }
    
    return spot
}


