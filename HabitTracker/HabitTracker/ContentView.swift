//
//  ContentView.swift
//  HabitTracker
//
//  Created by Matej Kuprešak on 16.08.2023..
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities.indices, id: \.self) { index in
                    NavigationLink {
                        ActivityView(activity: activities.activities[index], activities: activities, index: index)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activities.activities[index].name)
                                    .font(.headline)
                                    .padding(.bottom)
                                
                                Text(activities.activities[index].shortDescription)
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
