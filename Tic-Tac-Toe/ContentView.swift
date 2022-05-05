//
//  ContentView.swift
//  Tic-Tac-Toe
//

// Screen dimensions:

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    var body: some View {
        VStack {
            Text("❌⭕️❌⭕️❌⭕️")
                .font(.system(size: 30))
            Text("⭕️ Tic Tac Toe ❌")
                .font(.system(size: 30))
            Text("❌⭕️❌⭕️❌⭕️")
                .font(.system(size: 30))
            
            Text("")
            Text("GAME MODES:")
                .font(.system(size: 20))
                .padding(.bottom)
            
            VStack {
                Text("Learn to play")
                NavigationLink(destination: PvPHelpPage()) {
                    HStack {
                        Text("Play your friends with help!")
                    }
                }
                    .padding(.bottom)
                Text("Play unguided!")
                NavigationLink(destination: PvPPage()) {
                    HStack {
                        Text("Play your friends!")
                    }
                }
                    .padding(.bottom)
                Text("Play the smartest one in the room")
                NavigationLink(destination: PvCPUPage()) {
                    HStack {
                        Text("Face a computer!")
                    }
                }
                    .padding(.bottom)
                
                Text("Play the fastest one in the room")
                NavigationLink(destination: PvAlphaBetaPage()) {
                    HStack {
                        Text("Face a fast computer!")
                            .frame(alignment: .center)
                    }
                }
                    .padding(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
