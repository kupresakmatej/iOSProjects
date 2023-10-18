//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Matej Kuprešak on 06.09.2023..
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    @StateObject var favorites = Favorites()
    
    @State private var sortType = 1
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()

                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                HStack {
                    Spacer()
                    
                    Menu {
                        Button {
                            sortType = 1
                        } label: {
                            HStack {
                                Text("Default sort")
                                
                                Spacer()
                                
                                if sortType == 1 {
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                        }
                        
                        Button {
                           sortType = 2
                        } label: {
                            HStack {
                                Text("Alphabetical sort")
                                
                                Spacer()
                                
                                if sortType == 2 {
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                        }
                        
                        Button {
                            sortType = 3
                        } label: {
                            HStack {
                                Text("Country sort")
                                
                                Spacer()
                                
                                if sortType == 3 {
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    var sortedResorts: [Resort] {
        switch sortType {
        case 1:
            return resorts
        case 2:
            return resorts.sorted { $0.name < $1.name }
        default:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        var tempResorts = sortedResorts
        
        if searchText.isEmpty {
            return tempResorts
        } else {
            return tempResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
