//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Danielle Lewis on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameOver = false
    @State private var isGameOver = ""
    
    @State private var showAnimation = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionCount = 0
    
    @State private var animationAmount = 0.0
    
    @State private var tapped = -1
    @State private var notTapped = false
    
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            
            VStack {
                VStack {
                 
                    Text("Whose Flag Is It")
                    Text("Anyway?")
                 
                    Text("Score: \(userScore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                        .padding()
        
                }
                .font(.largeTitle.weight(.bold))
                .foregroundColor(.black)
           
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .rotation3DEffect(.degrees(tapped == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(tapped == -1 || tapped == number ? 1.0 : 0.25)
                                .scaleEffect(tapped == -1 || tapped == number ? 1.0 : 0.5)
                                .animation(.default, value: tapped)
                        }
                    }
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                    
                    
                    
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert(isGameOver, isPresented: $gameOver) {
            Button("Reset", action: reset)
        } message: {
            Text("Final Score: \(userScore). Start again?")
        }
    }
    
    
    func reset() {
        userScore = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tapped = -1
    }
    
    func finalScore() {
        if (questionCount == 8) {
            isGameOver = "Game Over"
            gameOver = true
        }
    }
    
    func flagTapped(_ number: Int) {
        tapped = number
        
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            questionCount += 1
            
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            questionCount += 1
        }
        
        showingScore = true
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
