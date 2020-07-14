//
//  FilteredList.swift
//  CoreDataChallenges
//
//  Created by Diana Harjani on 26/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//
import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue}
    
    @Environment(\.managedObjectContext) var moc //For deleting
    
    let content: (T) -> Content
    
//    init(filter: String){
//        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
    
    var body: some View {
        List{
            ForEach(fetchRequest.wrappedValue, id: \.self){ singer in
                self.content(singer)
            }.onDelete(perform: removeSinger(at: ))
        }
    }
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], filteringType: FilterType, @ViewBuilder content: @escaping (T) -> Content){ //CHALLENGE 1
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K  \(filteringType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    func removeSinger(at offsets: IndexSet){
        for index in offsets{
            let singer = singers[index]
            moc.delete(singer)
            do{
                try moc.save()
            } catch{
                print(error)
            }
        }
    }
    
    
    
}


