//
//  PvPHelpPage.swift
//  Tic-Tac-Toe 
//

import SwiftUI

// let sz = (UIScreen.screenWidth - 4 * 5) / 3
// var winnings = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

struct PvPHelpPage: View {
    @State private var showPopUp: Bool = false
    @State private var gameOver: Bool = false
    @State private var tie: Bool = false
    
    @State var turn = "X"
    @State var grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @State var c = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
    
    
    var body: some View {
        ZStack {
        VStack {
            Text("Player Versus Player")
                .font(.system(size: 30))
            Text("With some help!")
                .font(.system(size: 10))
            Text("Current: " + turn)
            Grid(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: true, cpuMode: false, abMode: false)
            
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
            
            if (tie) {
                PopUpWindow(title: "Tie", message: "Equal match", buttonText: "Play again!", gameOver: $gameOver, tie: $tie, grid: $grid, turn: $turn, col: $c)
            }
            else {
                PopUpWindow(title: "Winner: " + switchTurn(turn: turn) + "!", message: "Nice job :)", buttonText: "Play again!", gameOver: $gameOver, tie: $tie, grid: $grid, turn: $turn, col: $c)
                
            }
            
        }
    }
}

struct PvPHelpPage_Previews: PreviewProvider {
    static var previews: some View {
        PvPHelpPage()
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

func setGridWithHelp(arr:[String], turn: String) -> [String] {
    var ret = arr
    
    var other = "X"
    if other == turn {
        other = "O"
    }
    
    for i in 0...8 {
        if !(ret[i] == "X" || ret[i] == "O") {
            ret[i] = " "
        }
    }
    
    // YOURE IN TROUBLE!
    for combo in winnings {
        if (ret[combo[0]] == ret[combo[1]]) && ret[combo[0]] == other && ret[combo[2]] == " " {
            ret[combo[2]] = "Go here to block the enemy!"
        }
        if (ret[combo[1]] == arr[combo[2]]) && ret[combo[1]] == other && ret[combo[0]] == " " {
            ret[combo[0]] = "Go here to block the enemy!"
        }
        if (ret[combo[0]] == ret[combo[2]]) && ret[combo[2]] == other && ret[combo[1]] == " " {
            ret[combo[1]] = "Go here to block the enemy!"
        }
    }
    
    // YOU CAN WIN!
    for combo in winnings {
        if (ret[combo[0]] == ret[combo[1]]) && ret[combo[0]] == turn && ret[combo[2]] == " " {
            ret[combo[2]] = "Go here to win now!"
        }
        if (ret[combo[1]] == ret[combo[2]]) && ret[combo[1]] == turn && ret[combo[0]] == " " {
            ret[combo[0]] = "Go here to win now!"
        }
        if (ret[combo[0]] == ret[combo[2]]) && ret[combo[2]] == turn && ret[combo[1]] == " " {
            ret[combo[1]] = "Go here to win now!"
        }
    }
    return ret
}

func resetGridWithHelp(arr:[String]) -> [String] {
    var ret = arr
    
    for i in 0...8 {
        if !(ret[i] == "X" || ret[i] == "O") {
            ret[i] = " "
        }
    }
    
    return ret
}
