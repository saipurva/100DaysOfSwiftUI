//
//  DetailedView.swift
//  Day61
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct DetailedView: View {
    @ObservedObject var userLink: UserLink
    var user: User
    
    var body: some View {
        Form{
            Section(header: Text("User Info")){
                Text(user.address)
                Text(user.email)
            }
            Section(header: Text("Work")){
                Text(user.company)
            }
            Section{
                Text("Registered on: \(user.formattedRegisteredDate)")
            }
            
            Section(header: Text("Tags")){
                ScrollView(.horizontal){
                    HStack{
                        ForEach(user.tags, id: \.self){ tag in
                            Text(tag)
                                .foregroundColor(Color.primary)
                                .background(Color.secondary)
                                .cornerRadius(30)
                        }
                    }
                }
            }
            
            Section(header: Text("About")){
                Text(user.about)
            }

            
            Section(header: Text("Friends")){
                List(user.friends) { friend in
                    CellView(user: self.userLink.findUser(byName: friend.name)!)
                }
            }
        }
        .navigationBarTitle(Text("\(user.name) \(user.age)"), displayMode: .inline)
        .navigationBarItems(trailing: Circle()
        .foregroundColor(user.isActive ? Color.black : Color.red)
        .frame(width: 10, height: 10)
        )
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(userLink: UserLink(), user: User(id: "pof", name: "aai", age: 3, address: "posk", company: "mld", email: "sai@gamil", about: "sai", friends: [Friend(id: "pok", name: "sai")], tags: ["hello", "posk"],  registered: Date(), isActive: true))
    }
}
