//
//  ContentView.swift
//  Bookworm
//
//  Created by Diana Harjani on 22/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
   
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books, id: \.self){ book in
                    NavigationLink(destination: DetailedView(book: book)) {
                        EmojiView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? Color.red : .black) //Challenge 2
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("BookWorm")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
            
            })
                .sheet(isPresented: $showingAddScreen){
                    AddBook().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
