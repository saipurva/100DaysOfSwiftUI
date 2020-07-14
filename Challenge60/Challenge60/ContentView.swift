//
//  ContentView.swift
//  Challenge60
//
//  Created by Diana Harjani on 29/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userLink = UserLink()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(userLink.userlist){ user in
                    NavigationLink(destination: DetailedView(userLink: self.userLink, user: user)){
                        CellView(user: user)
                    }
                }
            }
        .navigationBarTitle("Chat  List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
