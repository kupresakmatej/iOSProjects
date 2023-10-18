//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matej Kuprešak on 08.08.2023..
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appCurrentChoice = Int.random(in: 0...2)
    @State private var shouldWin = true
    @State private var userInput = ""
    
    @State private var score = 0
    
    @State private var alertText = ""
    @State private var alertIsShowing = false
    
    @State private var gameOver = false
    
    @State private var round = 1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color.cyan, location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Text("Your current score is:")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title)
                
                Text("\(score)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.largeTitle.bold())
                    .padding()
                    .padding()
            
                Text("The app has chosen: \(moves[appCurrentChoice])")
                
                Text("This round you should try and \(shouldWin ? "win" : "lose").")
                    .font(.body.bold())
                
                Spacer()
                
                Text("Your move!")
                    .font(.title.bold())
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            handleUserInput(moves[number])
                        } label: {
                            if moves[number]  == "Rock" {
                                Text("🪨")
                                    .font(.system(size: 50))
                                    .padding()
                            } else if moves[number] == "Paper" {
                                Text("📄")
                                    .font(.system(size: 50))
                                    .padding()
                            } else {
                                Text("✂️")
                                    .font(.system(size: 50))
                                    .padding()
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Round \(round)")
                    .font(.body.bold())
            }
        }
        .alert(alertText, isPresented: $alertIsShowing) {
            Button("Next round", action: launchNextRound)
        } message: {
            Text("You used \(userInput).\nAnd the AI used \(moves[appCurrentChoice]).")
        }
        .alert("Game over!", isPresented: $gameOver)
        {
            Button("Restart", action: restartGame)
        } message: {
            Text("The game is over!\nYour final score was \(score).")
        }
    }
    
    func handleUserInput(_ userInput: String) {
        self.userInput = userInput
        
        if shouldWin {
            if userInput == moves[appCurrentChoice] {
                alertText = "It's a draw!"
            } else if userInput == "Rock" && moves[appCurrentChoice] == "Scissors" {
                score += 1
                alertText = "You win!"
            } else if userInput == "Scissors" && moves[appCurrentChoice] == "Paper" {
                score += 1
                alertText = "You win!"
            } else if userInput == "Paper" && moves[appCurrentChoice] == "Rock" {
                score += 1
                alertText = "You win!"
            } else {
                alertText = "You lose!"
                
                if score - 1 < 0 {
                    score = 0
                } else {
                    score -= 1
                }
            }
        } else {
            if userInput == moves[appCurrentChoice] {
                alertText = "It's a draw!"
            } else if userInput != "Rock" && moves[appCurrentChoice] == "Scissors" {
                alertText = "You win!"
                score += 1
            } else if userInput != "Scissors" && moves[appCurrentChoice] == "Paper" {
                score += 1
                alertText = "You win!"
            } else if userInput != "Paper" && moves[appCurrentChoice] == "Rock" {
                score += 1
                alertText = "You win!"
            } else {
                alertText = "You lose!"
                
                if score - 1 < 0 {
                    score = 0
                } else {
                    score -= 1
                }
            }
        }
        alertIsShowing = true
    }
    
    func launchNextRound() {
        appCurrentChoice = Int.random(in: 0...2)
        
        shouldWin.toggle()
        
        if round + 1 > 10 {
            gameOver = true
        } else {
            round += 1
        }
    }
    
    func restartGame() {
        score = 0
        round = 1
        
        appCurrentChoice = Int.random(in: 0...2)
        
        gameOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
