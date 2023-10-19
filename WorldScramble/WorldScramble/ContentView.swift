//
//  ContentView.swift
//  WorldScramble
//
//  Created by Matej Kuprešak on 09.08.2023..
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                            .accessibilityElement()
                            .accessibilityLabel(word)
                            .accessibilityHint("\(word.count) letters.")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle(rootWord)
                .toolbar() {
                    Button("Reroll", action: startGame)
                }
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("Ok", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
                
                Text("Your score is \(score).")
                    .padding()
                    .font(.headline.bold())
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard answer.count > 0 else { return }
        
        guard !isTooShort(word: answer) else {
            wordError(title: "Word too short!", message: "Your word should be at least 3 letters long.")
            
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already.", message: "Be more original.")
            
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible.", message: "You can't spell that word from \(rootWord)!")
            
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized.", message: "You can't just make them up.")
            
            return
        }
        
        guard isStartWord(word: answer) else {
            wordError(title: "Word same as root.", message: "Your word cannot be the same as the root word.")
            
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
        
        score += answer.count * 2
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                score = 0
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isTooShort(word: String) -> Bool {
        if word.count < 3 {
            return true
        }
        
        return false
    }
    
    func isStartWord(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
