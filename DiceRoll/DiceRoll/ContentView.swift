//
//  ContentView.swift
//  DiceRoll
//
//  Created by Matej Kuprešak on 05.09.2023..
//

import SwiftUI

struct ContentView: View {
    @StateObject var dice = Dice()
    
    @State private var result = 0
    
    private let types = [4, 6, 8, 10, 12, 20, 100]
    
    @State private var results = [Int]()
    
    @State private var showingSaveAlert = false
    @State private var showingSaveFailedAlert = false

    @State private var timer: Timer?
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedResults")
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("Choose dice type")
                            .font(.headline)
                        Picker("Dice type", selection: $dice.type) {
                            ForEach(types, id: \.self) { type in
                                Text("\(type)")
                            }
                        }
                        HStack {
                            Button("Roll", action: rollDice)
                                .buttonStyle(BorderedButtonStyle())
                                .onTapGesture(perform: simpleSuccess)
                                .font(.body.bold())
                                .shadow(radius: 10)
                            
                            Spacer()
                            
                            Button("Save results", action: saveResult)
                                .buttonStyle(BorderedButtonStyle())
                                .foregroundColor(.green)
                                .onTapGesture(perform: simpleSuccess)
                                .font(.body.bold())
                                .shadow(radius: 10)
                        }
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 200, height: 200)
                                    .foregroundColor(.secondary)
                                    .opacity(0.50)
                                    .shadow(radius: 10)
                                
                                Text("\(result)")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Section {
                        List {
                            ForEach(results, id: \.self) { result in
                                Text("\(result)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Dice roller")
            .alert("Saved to documents", isPresented: $showingSaveAlert) {
                Button("Ok") {}
            }
            .alert("Failed to save", isPresented: $showingSaveFailedAlert) {
                Button("Try again", action: saveResult)
            }
            .onAppear(perform: loadData)
        }
    }
    
    func rollDice() {
        timer?.invalidate()
        
        var rollCounter = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            result = Int.random(in: 1...dice.type)
                rollCounter += 1
                if rollCounter == 5 {
                    timer?.invalidate()
                    results.append(result)
                }
        })
    }
    
    func saveResult() {
        do {
            let data = try JSONEncoder().encode(results)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Data saved successfully at: \(savePath)")
            
            showingSaveAlert = true
        } catch {
            print("Error saving data: \(error)")
            
            showingSaveFailedAlert = true
        }
    }
    
    func loadData() {
        self.results = []
        
        do {
            let data = try Data(contentsOf: savePath)
            results = try JSONDecoder().decode([Int].self, from: data)
            print("Data loaded sucessfully")
        } catch {
            results = []
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
