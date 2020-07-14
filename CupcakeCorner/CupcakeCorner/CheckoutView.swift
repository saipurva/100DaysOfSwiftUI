//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Diana Harjani on 19/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var shownalert = false
    
    @State private var networkError = true
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(removeTraits: .isImage) //challenge 1 day 76 
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $shownalert){
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    //        .alert(isPresented: $showingConfirmation){
    //            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
    //        }

        .navigationBarTitle("Check out", displayMode: .inline)
        
    }
    func placeOrder(){
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            //handle result
            guard let data = data else {  //Challenge 2 day 52
              //  print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    self.alertTitle = "\(error?.localizedDescription ?? "Unknown error")"
                    self.alertMessage = "Please check your Internet and try again."
                    self.shownalert = true
                    return
            }
            
            if let DecodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                    //self.confirmationMessage = "Your order for \(DecodedOrder.quantity) x \(Order.types[DecodedOrder.type].lowercased()) cupcakes is on its way!"
                self.alertTitle = "Thank you!"
                self.alertMessage = "Your order for \(DecodedOrder.quantity) x \(Order.types[DecodedOrder.type].lowercased()) cupcakes is on its way!"
                self.shownalert = true
                } else {
                    print("Invalid response from server")
                }
            
        }.resume()
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
