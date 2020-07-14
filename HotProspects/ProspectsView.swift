//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Diana Harjani on 27/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSheet = false
    @State private var isSortbyName = true
    
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted}
        }
    }
    
    var filteredContacts: [Prospect] {
        if isSortbyName { //Sort contacts by name
            return  filteredProspects.sorted(by: { $0.name < $1.name})
        } else {
            return filteredProspects.reversed() //sort contacts by last added
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(filteredProspects) { prospect in
                    HStack{ //CHALLENGE 1
                        if prospect.isContacted {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "person.fill")
                                .foregroundColor(.red)
                        }
                        //                        Image(systemName: "person.fill")
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu{
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems( //challenge 3 sort
                leading: Button(action: { self.isShowingSheet = true
                }) { Image(systemName: "arrow.up.arrow.down.square")
                    Text("Sort")},
                trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
            .actionSheet(isPresented: $isShowingSheet){
                ActionSheet(title: Text("Sort contacts by"), buttons: [.default(Text("Name")) {
                    self.isSortbyName = true
                    }, .default(Text("Recent")) {
                        self.isSortbyName = false
                    }, .cancel()])
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "PaulHudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        //more code tocome
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
            
        case .failure(let error):
            print("Scanning  failed")
        }
        
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            //            var dateComponents = DateComponents()
            //            DateComponents.hour = 9
            //
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Doh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
