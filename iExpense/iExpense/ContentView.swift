//
//  ContentView.swift
//  iExpense
//
//  Created by Diana Harjani on 07/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        didSet{
            let encoder =  JSONEncoder()
            if let enconded = try? encoder.encode(items){
                UserDefaults.standard.set(enconded, forKey: "Items")
            }
        }
    }
    
    init() {
        if  let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$ \(item.amount)")
                            .foregroundColor(self.color(foramount: item.amount)) //challenge 2
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }, trailing: EditButton()) //Challenge 1 (day 38)
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    func color(foramount amount: Int) -> Color { //challenge 2
        switch  amount{
        case 0..<10:
            return .blue
        case 10...30:
            return .green
        case 30..<50:
            return .orange
        case 50..<100:
            return .purple
        case 100..<1000:
            return .red
        default:
            return .black
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
