//
//  PvPPageHelp.swift
//  Tic-Tac-Toe
//
//  Created by Gregory Bove on 4/18/22.
//

import SwiftUI

// let sz = (UIScreen.screenWidth - 4 * 5) / 3
// var winnings = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

struct PvPPageHelp: View {
    @State private var showPopUp: Bool = false
    @State private var gameOver: Bool = false
    @State var turn = "X"
    @State var grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @State var c = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
    
    
    var body: some View {
        ZStack {
        VStack {
            Text("Player Versus Player")
                .font(.system(size: 30))
            Text("Current: " + turn)
            Grid(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver)
            
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
                            // .font(.headline)
                            .foregroundColor(.black)
                    }
                }
            }
        }
            
            PopUpWindow(title: "Winner", message: "Nice job :)", buttonText: "Play again!", show: $gameOver, grid: $grid, turn: $turn, col: $c)
            
        }
    }
}

struct PvPPageHelp_Previews: PreviewProvider {
    static var previews: some View {
        PvPPageHelp()
    }
}


func setColorsWithHelp(arr:[String], turn: String) -> [Color] {
    var ret = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
    
    var other = "X"
    if other == turn {
        other = "O"
    }
    
    // YOURE IN TROUBLE!
    for combo in winnings {
        if (arr[combo[0]] == arr[combo[1]]) && arr[combo[0]] == other && arr[combo[2]] == " " {
            ret[combo[2]] = Color.orange
        }
        if (arr[combo[1]] == arr[combo[2]]) && arr[combo[1]] == other && arr[combo[0]] == " " {
            ret[combo[0]] = Color.orange
        }
        if (arr[combo[0]] == arr[combo[2]]) && arr[combo[2]] == other && arr[combo[1]] == " " {
            ret[combo[1]] = Color.orange
        }
    }
    
    // YOU CAN WIN!
    for combo in winnings {
        if (arr[combo[0]] == arr[combo[1]]) && arr[combo[0]] == turn && arr[combo[2]] == " " {
            ret[combo[2]] = Color.blue
        }
        if (arr[combo[1]] == arr[combo[2]]) && arr[combo[1]] == turn && arr[combo[0]] == " " {
            ret[combo[0]] = Color.blue
        }
        if (arr[combo[0]] == arr[combo[2]]) && arr[combo[2]] == turn && arr[combo[1]] == " " {
            ret[combo[1]] = Color.blue
        }
    }
    // Game Over
    for combo in winnings {
        if (arr[combo[0]] == arr[combo[1]]) && (arr[combo[0]] == arr[combo[2]]) {
            if (arr[combo[0]] != " ") {
                ret[combo[0]] = Color.red
                ret[combo[1]] = Color.red
                ret[combo[2]] = Color.red
            }
        }
    }
    return ret
}

struct Box: View {
    @Binding var grid: [String]
    @Binding var c: [Color]
    @Binding var turn: String
    @Binding var gameOver: Bool
    
    var idx: Int
    
    var body: some View {
        ZStack {
            Button(action: {
                if (grid[idx] == " ") {
                    grid[idx] = turn
                    turn = switchTurn(turn: turn)
                    c = setColorsWithHelp(arr:grid, turn: turn)
                    gameOver = checkWin(arr: grid)
                }
            }) {
                ZStack {
                    Rectangle()
                        .fill(c[idx])
                        .frame(width: sz, height: sz)
                    Text(grid[idx])
                        .font(.system(size: 60))
                }
            }
        }
    }
}
