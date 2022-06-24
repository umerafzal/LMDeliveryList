//
//  DeliveryResponse.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

struct DeliveryResponse: Decodable {
  let delivery_id: String
  let delivery_goodsPicture: String
  let delivery_surcharge: String
  let delivery_deliveryFee: String
  let delivery_sender: DeliveryResponse.Sender
  let delivery_route: DeliveryResponse.Route
}

extension DeliveryResponse {
  struct Sender: Decodable  {
    let delivery_name: String
    let delivery_email: String
    let delivery_phone: String
  }
  struct Route: Decodable {
    let delivery_start: String
    let delivery_end: String
  }
}

extension DeliveryResponse: DeliveryDTO {
  var isFavourite: Bool {
    false
  }

  var sender: DeliverySenderDTO {
    delivery_sender
  }

  var route: DeliveryRouteDTO {
    delivery_route
  }

  var id: String {
    delivery_id
  }

  var goodsPicture: String {
    delivery_goodsPicture
  }

  var surcharge: String {
    delivery_surcharge
  }

  var deliveryFee: String {
    delivery_deliveryFee
  }

}

extension DeliveryResponse.Sender: DeliverySenderDTO {
  var name: String {
    delivery_name
  }

  var email: String {
    delivery_email
  }

  var phone: String {
    delivery_phone
  }
}

extension DeliveryResponse.Route: DeliveryRouteDTO {
  var start: String {
    delivery_start
  }

  var end: String {
    delivery_end
  }
}
