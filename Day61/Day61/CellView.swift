//
//  CellView.swift
//  Day61
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct CellView: View {
    var user: User
    
    var body: some View {
        VStack{
            HStack{
                Circle()
                .foregroundColor(user.isActive ? Color.black : Color.red)
                .frame(width: 10, height: 10)
                Text(user.name)
                    .foregroundColor(user.isActive ? Color.blue : Color.red)
                Text("\(user.age)")
            }
           
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(user: User(id: "po", name: "kd", age: 3, address: "prashanti", company: "apple", email: "so@gmail", about: "ofm", friends: [Friend(id: "ofm", name: "po")], tags: ["pkd", "ksp"], registered: Date(), isActive: true))
    }
}
