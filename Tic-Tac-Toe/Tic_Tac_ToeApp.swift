//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe 
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct Box: View {
    @Binding var grid: [String]
    @Binding var c: [Color]
    @Binding var turn: String
    @Binding var gameOver: Bool
    @Binding var tie: Bool
    
    var helpMode: Bool
    var cpuMode: Bool
    var abMode: Bool
    var randomMode: Bool
    var idx: Int
    var textSize: CGFloat = 60
    
    var body: some View {
        ZStack {
            Button(action: {
                if (helpMode) {
                    grid = resetGridWithHelp(arr:grid)
                }
                if !(grid[idx] == "X" || grid[idx] == "O") {
                    grid[idx] = turn
                    turn = switchTurn(turn: turn)
                    if (helpMode) {
                        c = setColorsWithHelp(arr:grid, turn: turn)
                        grid = setGridWithHelp(arr:grid, turn: turn)
                    }
                    else {
                        c = setColorsNoHelp(arr:grid, turn: turn)
                    }
                    tie = (checkFull(arr: grid) && !checkWin(arr: grid))
                    gameOver = checkDone(arr: grid)
                    
                    if (cpuMode && !gameOver && !tie) {
                        if (abMode) {
                            grid[findBestMoveAB(board: grid)] = turn
                        }
                        else if (randomMode) {
                            print("random")
                            grid[findBestMoveRandom(board: grid)] = turn
                        }
                        else {
                            grid[findBestMove(board: grid)] = turn
                        }
                        c = setColorsNoHelp(arr:grid, turn: turn)
                        turn = switchTurn(turn: turn)
                        tie = (checkFull(arr: grid) && !checkWin(arr: grid))
                        gameOver = checkDone(arr: grid)
                    }  
                }
            }) {
                ZStack {
                    Rectangle()
                        .fill(c[idx])
                        .frame(width: sz, height: sz)
                    if (grid[idx].count > 2) {
                        Text(grid[idx])
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                    }
                    else {
                        Text(grid[idx])
                        .font(.system(size: 60))
                    }
                }
            }
        }
    }
}

struct Row: View {
    @Binding var grid: [String]
    @Binding var c: [Color]
    @Binding var turn: String
    @Binding var gameOver: Bool
    @Binding var tie: Bool
    
    var helpMode: Bool
    var cpuMode: Bool
    var abMode: Bool
    var randomMode: Bool
    
    var idx: Int
    
    var body: some View {
        ZStack {
            Box(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 3*idx)
        }
        ZStack {
            Box(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 3*idx+1)
        }
        ZStack {
            Box(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 3*idx+2)
        }
    }
}

struct Grid: View {
    @Binding var grid: [String]
    @Binding var c: [Color]
    @Binding var turn: String
    @Binding var gameOver: Bool
    @Binding var tie: Bool
    
    var helpMode: Bool
    var cpuMode: Bool 
    var abMode: Bool
    var randomMode: Bool
    
    var body: some View {
        HStack {
            Row(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 0)
        }
        HStack {
            Row(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 1)
        }
        HStack {
            Row(grid: $grid, c: $c, turn: $turn, gameOver: $gameOver, tie: $tie, helpMode: helpMode, cpuMode: cpuMode, abMode: abMode, randomMode: randomMode, idx: 2)
        }
    }
}

func checkDone(arr:[String]) -> Bool {
    if checkFull(arr: arr) {
        return true
    }
    if checkWin(arr: arr) {
        return true
    }
    return false
}
func checkFull(arr:[String]) -> Bool {
    for elem in arr {
        if !(elem == "X" || elem == "O") {
            return false
        }
    }
    return true
}

func checkWin(arr:[String]) -> Bool {
    for combo in winnings {
        if (arr[combo[0]] == arr[combo[1]]) && (arr[combo[0]] == arr[combo[2]]) {
            if (arr[combo[0]] == "X") || (arr[combo[0]] == "O") {
                return true
            }
        }
    }
    return false
}

func findWinner(arr:[String]) -> String {
    for combo in winnings {
        if (arr[combo[0]] == arr[combo[1]]) && (arr[combo[0]] == arr[combo[2]]) {
            if (arr[combo[0]] != " ") {
                return arr[combo[0]]
            }
        }
    }
    return "No winner"
}

func switchTurn(turn: String) -> String {
    if (turn == "X") {
        return "O"
    }
    return "X"
}

struct PopUpWindow: View {
    var title: String
    var message: String
    var buttonText: String
    
    @Binding var gameOver: Bool
    @Binding var tie: Bool
    @Binding var grid: [String]
    @Binding var turn: String
    @Binding var col: [Color]
    

    var body: some View {
        ZStack {
            if gameOver {
                Color.black.opacity(gameOver ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color.white)

                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.3)) {
                            gameOver = false
                            grid = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
                            col = [Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green, Color.green]
                            turn = "X"
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
                            .font(Font.system(size: 23, weight: .semibold))
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
            }
        }
    }
}
