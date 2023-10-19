//
//  ContentView.swift
//  NameRemember
//
//  Created by Matej Kuprešak on 23.08.2023..
//

import SwiftUI

struct ContentView: View {  
    @State private var isShowingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    @State private var isPicturePicked = false
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    @State private var people: [Person] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(people, id: \.self) { person in
                        NavigationLink {
                            DetailView(person: person)
                        } label: {
                            HStack {
                                Image(uiImage: UIImage(data: person.imageData!)!)
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .scaledToFit()
                                    .clipShape(Circle())
                                
                                Text(person.name)
                            }
                        }
                    }
                }
                .navigationTitle("Remember the name")

                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            isShowingImagePicker = true
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: Binding<Bool>(
                get: { inputImage != nil },
                set: { newValue in
                    if newValue == false {
                        inputImage = nil
                    }
                }
            )) {
                SavePersonView(image: inputImage!, people: $people)
            }
        }
    }
    
    init() {
        self.people = []
        
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
