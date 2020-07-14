//
//  AddView.swift
//  iExpense
//
//  Created by Diana Harjani on 08/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save"){
                    if let actualAmount = Int(self.amount){
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    } else { //challenge 3
                        self.showAlert = true}
            })
        }.alert(isPresented: $showAlert){ //challenge 3
            Alert(title: Text("Error"), message: Text("Please enter a numeral number"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
