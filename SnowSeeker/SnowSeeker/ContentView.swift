//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Diana Harjani on 07/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

enum SortType{ //challenge3 day99
    case none, alphabetical, country
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    //challenge 3 day 99
    @State private var countryFilt = "All"
    @State private var sizeFilt = 0
    @State private var priceFil = 0
    
    @State private var sortingType  = SortType.none
    
    @State private var isShowingSotSheet = false
    @State private var isFilterSheet = true
    
    
    var sortedResorts: [Resort ]{
        switch sortingType{
        case .none:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: { $0.name  < $1.name })
        case .country:
            return resorts.sorted(by: { $0.country < $1.country})
        }
    }
    
    var filteredResorts: [Resort] {
        var tempResorts = sortedResorts
        
        tempResorts = tempResorts.filter  { (resorts) -> Bool in
            resorts.country == self.countryFilt || self.countryFilt == "All"
        }
        tempResorts  = tempResorts.filter { (resorts) -> Bool in
            resorts.size == self.sizeFilt || self.sizeFilt == 0
        }
        tempResorts = tempResorts.filter { (resorts) ->  Bool in
            resorts.price == self.priceFil || self.priceFil == 0
        }
        return tempResorts
    }
    
    var body: some View {
        NavigationView{
            List(filteredResorts) { resort in
                //            List(resorts) { resort  in
                NavigationLink(destination:
                ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                    )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                    )
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: { //challenge 3
                    self.isFilterSheet.toggle()
                }) { Text("Filter ")}, trailing: Button(action: {
                    self.isShowingSotSheet.toggle()
                }) { Text(" Sort ")}
            )
                .sheet(isPresented: $isFilterSheet){
                    FilterView(countryFilt: self.$countryFilt, sizeFilt: self.$sizeFilt, priceFilt: self.$priceFil)
            }
            .actionSheet(isPresented: $isShowingSotSheet) { () ->  ActionSheet in
                ActionSheet(title: Text("Sort by: "), message: nil, buttons:[
                    .default(Text("Alphabetical"), action:  { self.sortingType = .alphabetical }),
                    .default(Text("Country"), action: { self.sortingType = .country }),
                    .destructive(Text("Cancel")) //challege 3
                ])
            }
            WelcomeView()

        }
        .environmentObject(favorites)
        //    .phoneOnlyStackNavigationView()
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View{
        if UIDevice.current.userInterfaceIdiom == .phone{
            return
                AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
            
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
