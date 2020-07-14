////
////  OrderStruct.swift
////  CupcakeCorner
////
////  Created by Diana Harjani on 20/05/2020.
////  Copyright © 2020 Saipurva. All rights reserved.
////
//
//import Foundation
//
//
//class Order: ObservableObject {   //CHALLENGE 3 DAY 52, projec t 10
//    @Published var orderInfo: OrderInfo
//
//    enum CodingKeys: CodingKey{
//        case orderInfo
//       // case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//    init() {
//        self.orderInfo = OrderInfo()
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(orderInfo, forKey: .orderInfo)
//    }
//
//
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        orderInfo = try container.decode(OrderInfo.self, forKey: .orderInfo)
//    }
//}
//
//struct OrderInfo: Codable {
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//
//    var type = 0
//    var quantity = 3
//
//    var specialRequestEnabled = false{
//        didSet{
//            if !specialRequestEnabled {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//
//    }
//
//    var extraFrosting = false
//   var addSprinkles = false
//
//    //Address View
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
//
//    //TO make sure all textfields is typed.
//    var hasValidAddress: Bool{
//
////        let name = self.name.trimmingCharacters(in: .whitespaces)  //challenge 1 day 52
////        let streetAddress = self.streetAddress.trimmingCharacters(in: .whitespaces)
////        let city = self.city.trimmingCharacters(in: .whitespaces)
////        let zip = self.zip.trimmingCharacters(in: .whitespaces)
//
//        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
//            return false
//        }
//        return true
//    }
//
//    // checkout
//    var cost: Double{
//        //$2 per cake
//        var cost = Double(quantity) * 2
//        //complicated cakes cost more
//        cost += (Double(type) / 2)
//        //$1/cake for extra frosting
//        if extraFrosting{
//            cost += Double(quantity)
//        }
//        //$0.50/cake for sprinkles
//        if addSprinkles{
//            cost += Double(quantity) / 2
//        }
//        return cost
//    }
//}
//
//
