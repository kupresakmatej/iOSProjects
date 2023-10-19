//
//  SavePerson.swift
//  NameRemember
//
//  Created by Matej Kuprešak on 23.08.2023..
//

import SwiftUI

struct SavePersonView: View {
    private var image: UIImage
    @Binding private var people: [Person]
    
    @State private var name: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("Enter the persons name")
                        TextField("Name", text: $name)
                    }
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationTitle("Person details")
            .toolbar {
                HStack{
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                    
                    Button("Save") {
//                        let uiImage = image.asUIImage()

                        let person = Person(id: UUID(), name: name, imageData: image.jpegData(compressionQuality: 0.8))

                        people.append(person)
                        save()
                    }
                }
            }
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Data saved successfully at: \(savePath)")
        } catch {
            print("Error saving data: \(error)")
        }

        dismiss()
    }
    
    init(image: UIImage, people: Binding<[Person]>) {
        self.image = image
        self._people = people
    }
}

struct SavePerson_Previews: PreviewProvider {
    static var previews: some View {
        SavePersonView(image: UIImage(), people: .constant([]))
    }
}
