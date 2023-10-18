//
//  ContentView.swift
//  Edutainment
//
//  Created by Matej Kuprešak on 11.08.2023..
//

import SwiftUI

struct Question {
    var table = 0
    var multiply = 0
    var answer = 0
    
    init(table: Int, multiply: Int, answer: Int) {
        self.table = table
        self.multiply = multiply
        self.answer = answer
    }
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numOfQuestionsWanted = 5
    
    @State private var currentQuestionNumber = 1
    
    @State private var questions = [Question]()
    
    @State private var isShowing = false
    
    @State private var answer = [String]()
    
    @State private var correctAnswers = 0
    
    @State private var showAlert = false
    
    let numberOfQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        Text("Choose the multiplication table.")
                            .font(.headline)
                        
                        Stepper("Multiply with: \(multiplicationTable)", value: $multiplicationTable, in: 2...12)
                    }
                    
                    Section {
                        Text("How many problem will you solve?")
                            .font(.headline)
                        
                        Picker("", selection: $numOfQuestionsWanted) {
                            ForEach(numberOfQuestions, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button("Generate", action: generateQuestions)
                                .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    Section {
                        Text("Questions!")
                            .font(.headline)
                        
                        if isShowing {
                            ForEach(questions.indices, id: \.self) { index in
                                
                                HStack {
                                    Text("\(questions[index].table) x \(questions[index].multiply) =")
                                    
                                    Spacer()
                                    
                                    TextField("Tap to answer", text: $answer[index])
                                        .keyboardType(.numberPad)
                                }
                            }
                            
                            HStack {
                                Spacer()
                                
                                Button("Submit", action: submitAnswers)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edutainment")
            .alert("Test is over!", isPresented: $showAlert) {
                Button("Restart", action: restartApp)
            } message: {
                Text(correctAnswers == 1 ? "You got \(correctAnswers) question right!" : "You got \(correctAnswers) questions right!")
            }
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        answer.removeAll()
        
        for i in 1...numOfQuestionsWanted {
            var numberToMultiplyWith = Int.random(in: 1...multiplicationTable)
            
            questions.append(Question(table: multiplicationTable, multiply: numberToMultiplyWith, answer: (multiplicationTable * numberToMultiplyWith)))
            
            answer.append("")
        }
        
        withAnimation {
            isShowing = true
        }
    }
    
    func submitAnswers() {
        for i in 0..<questions.count {
            if((questions[i].table * questions[i].multiply) == Int(answer[i])) {
                correctAnswers += 1
            }
        }
        
        showAlert = true
    }
    
    func restartApp() {
        isShowing = false
        
        correctAnswers = 0

        questions.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
