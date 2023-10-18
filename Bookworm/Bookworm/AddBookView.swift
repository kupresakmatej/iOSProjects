//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matej Kuprešak on 17.08.2023..
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        // saving a book
                        
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        
                        if ((newBook.title?.isEmpty) == nil) || ((newBook.author?.isEmpty) == nil) ||
                            ((newBook.genre?.isEmpty) == nil) || ((newBook.review?.isEmpty) == nil) {
                            
                            newBook.title = "Unknown title"
                            newBook.author = "Unknown author"
                            newBook.rating = 5
                            newBook.genre = "Unknown genre"
                            newBook.review = "No review"
                            newBook.date = "\(Date.now.formatted())"
                        }
                        
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = "\(Date.now.formatted())"
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
