//
//  UserLink.swift
//  Challenge60
//
//  Created by Diana Harjani on 29/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation


class UserLink: ObservableObject {
    @Published var userlist = [User]()
    init() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                print("No data in response \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.userlist = decodedUsers
                }
            }
            catch let error{
                print("error: \(error)")
            }
        }.resume()
    }
    
    func findUser(byName name: String) -> User?{
        if let user = userlist.first(where: {
            $0.name == name
        }) {
            return user
        }
        return userlist.first
    }
    
}
    
    
    
