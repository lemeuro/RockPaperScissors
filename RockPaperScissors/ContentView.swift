//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Lem Euro on 12/03/2023.
//

import SwiftUI

struct ContentView: View {
    let moves = ["🎸", "💵", "🔥"]
    
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var round = 1
    @State private var showingResults = false
    
    var body: some View {
        VStack {
            Group {
                Spacer()
                
                Text("My choise is")
                    .font(.headline)
                
                Text(moves[computerChoice])
                    .font(.system(size: 72))
                
                Spacer()
            }
            
            Group {
                Text("You must")
                    .font(.title)
                Text(shouldWin ? "WIN" : "LOSE")
                    .font(.largeTitle).bold()
                    .foregroundColor(shouldWin ? .green : .red)
                
                Spacer()
            }
            
            Group {
                Text("Select your move")
                    .font(.headline)
                
                HStack {
                    ForEach(0..<moves.count, id: \.self) { number in
                        Button {
                            play(choice: number)
                        } label: {
                            Text(moves[number])
                        }
                    }
                }
                .font(.system(size: 80))
                
                Spacer()
            }
            
            Text("Score: \(score)")
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game Over", isPresented: $showingResults) {
            Button("New Game", action: newGame)
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func play(choice: Int) {
        let winMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winMoves[computerChoice]
        } else {
            didWin = winMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if round == 10 {
            showingResults = true
        } else {
            nextRound()
        }
    }
    
    func nextRound() {
        shouldWin.toggle()
        round += 1
        computerChoice = Int.random(in: 0...2)
    }
    
    func newGame() {
        round = 0
        score = 0
        nextRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
