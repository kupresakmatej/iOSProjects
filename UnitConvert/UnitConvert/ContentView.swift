//
//  ContentView.swift
//  UnitConvert
//
//  Created by Matej Kuprešak on 06.08.2023..
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "Days"
    @State private var outputUnit = "Days"
    @State private var valueToConvert = 0.0
    
    let units = ["Days", "Hours", "Minutes", "Seconds"]
    
    var outputValue: Double {
        let userInputUnit = inputUnit
        let userOutputUnit = outputUnit
        
        var defaultConvert = 0.0
        var result = 0.0
        
        if userInputUnit == "Days"
        {
            defaultConvert = valueToConvert * 24.0
        } else if userInputUnit == "Hours" {
            defaultConvert = valueToConvert
        } else if userInputUnit == "Minutes" {
            defaultConvert = valueToConvert / 60.0
        } else {
            defaultConvert = valueToConvert / 3600.0
        }
        
        if userOutputUnit == userInputUnit {
            result = valueToConvert
        } else if userOutputUnit == "Days" {
            result = defaultConvert / 24.0
        } else if userOutputUnit == "Hours" {
            result = defaultConvert
        } else if userOutputUnit == "Minutes" {
            result = defaultConvert * 60.0
        } else {
            result = defaultConvert * 3600.0
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Pick the input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Section {
                        TextField("Input the value to convert", value: $valueToConvert, format: .number)
                    }
                } header: {
                    Text("Pick the input unit")
                }
                
                Section {
                    Picker("Pick the output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Section {
                        Text("\(outputValue, specifier: "%.2f")")
                    }
                } header: {
                    Text("Pick the output unit")
                }
            }
            .navigationTitle("Time converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
