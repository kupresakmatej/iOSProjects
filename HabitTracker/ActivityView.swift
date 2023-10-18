//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Matej Kuprešak on 16.08.2023..
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    
    @ObservedObject var activities: Activities
    
    let index: Int
    
    var body: some View {
        ScrollView {
            Spacer()
                
            VStack {
                VStack {
                    HStack {
                        Text(activity.name)
                            .font(.largeTitle.bold())
                            .padding()
                        
                        Spacer()
                        
                        Text("Completed \(activity.completionCount) \(activity.completionCount == 1 ? "time" : "times").")
                            .padding()
                            .font(.headline)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button("Complete") {
                            var newActivity = activity
                            
                            newActivity.completionCount += 1
                            
                            activities.activities[index] = newActivity
                        }
                        .padding(.trailing)
                        .buttonStyle(.borderedProminent)
                    }
                }
                    
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                    .padding(.vertical)
                    
                Text(activity.description)
                    .font(.headline.bold())
            }
        }
    }
    
    init(activity: Activity, activities: Activities, index: Int) {
        self.activity = activity
        self.activities = activities
        self.index = index
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let activity = Activity(name: "Test", shortdescription: "Hehe", description: "Hehehe", completionCount: 1)
    
    static var previews: some View {
        ActivityView(activity: activity, activities: Activities(), index: 0)
    }
}
