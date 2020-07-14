//
//  DetailedView.swift
//  Bookworm
//
//  Created by Diana Harjani on 23/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailedView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var dateformat: String {
           guard let date = book.date else {
               return ""

           }
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return "Reviewed on \(formatter.string(from: date))"
       }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                        
                       
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity((0.75)))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Section{
                    Text(self.book.author ?? "Unknown author")
                        .font(.title)
                        .foregroundColor(.secondary)
                    Text(self.book.review ?? "No review")
                    .padding()
                    RatingView(rating: .constant(Int(self.book.rating)))
                        .font(.largeTitle)
                    Text(self.dateformat)
                        .padding(.all)
                    
                }
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")){
                self.deleteBook()
                }, secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
        self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    
   
//    func dateformat() -> String {
//        var components = DateComponents()
//        let date = Calendar.current.date(from: components) ?? Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "y-MM-dd"
//        formatter.dateStyle = .long
//        return "Reviewed on\(formatter.string(from: date))"
//    }
   

    func deleteBook(){
        moc.delete(book)
        
//        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct DetailedView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it"
        return NavigationView{
            DetailedView(book: book)

        }
    }
}
