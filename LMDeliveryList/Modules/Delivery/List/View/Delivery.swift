//
//  Delivery.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

struct Delivery {
  let id: String
  let imageURL: String
  let surchargeFee: String
  let deliveryFee: String
  let isFavourite: Bool
  let sender: Delivery.Sender
  let route: Delivery.Route
}

extension Delivery {
  struct Sender {
    let name: String
    let email: String
    let phoneNumber: String
  }
  struct Route {
    let to: String
    let from: String
  }
}

extension Delivery {
  var totalFee: String {
    let totalFee = deliveryFee.removeFormatAmount() + surchargeFee.removeFormatAmount()
    return "$\(totalFee)"
  }
}
