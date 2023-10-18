//
//  DetailView.swift
//  NameRemember
//
//  Created by Matej Kuprešak on 24.08.2023..
//

import SwiftUI

struct DetailView: View {
    private var person: Person
    
    var body: some View {
        VStack {
            Text("\(person.name) details.")
                .padding()
                
            Spacer()
                
            Image(uiImage: UIImage(data: person.imageData!)!)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .shadow(radius: 0.5)
            
            Spacer()
            Spacer()
        }
    }
    
    init(person: Person) {
        self.person = person
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(id: UUID(), name: "Person"))
    }
}
