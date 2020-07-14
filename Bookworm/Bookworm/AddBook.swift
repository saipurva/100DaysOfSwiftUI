//
//  AddBook.swift
//  Bookworm
//
//  Created by Diana Harjani on 23/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct AddBook: View {
    @Environment(\.managedObjectContext) var  moc
     @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry",  "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Name of Book", text:  $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){ Text($0)
                        }
                    }
                }
                Section{
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                Section{
                    Button("Save") {
                        //add book")
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        newBook.date = Date() //challenge 3
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.disabled(genre.isEmpty)//challenge 1
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
