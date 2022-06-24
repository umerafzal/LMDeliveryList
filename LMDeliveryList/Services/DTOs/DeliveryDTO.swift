//
//  DeliveryDTO.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol DeliveryDTO {
  var id: String { get }
  var goodsPicture: String { get }
  var surcharge: String { get }
  var deliveryFee: String { get }
  var isFavourite: Bool { get }
  var sender: DeliverySenderDTO { get }
  var route: DeliveryRouteDTO { get }
}

protocol DeliverySenderDTO {
  var name: String { get }
  var email: String { get }
  var phone: String { get }
}

protocol DeliveryRouteDTO {
  var start: String { get }
  var end: String { get }
}
