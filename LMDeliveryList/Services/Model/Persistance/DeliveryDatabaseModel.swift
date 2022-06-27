//
//  DeliveryDatabaseModel.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

struct DeliveryDatabaseModel: Codable {
  var delivery_id: String
  var delivery_goodsPicture: String
  var delivery_surcharge: String
  var delivery_deliveryFee: String
  var delivery_isFavorite: Bool
  var delivery_sender: DeliveryDatabaseModel.Sender
  var delivery_route: DeliveryDatabaseModel.Route

  init(
    delivery_id: String,
    delivery_goodsPicture: String,
    delivery_surcharge: String,
    delivery_deliveryFee: String,
    delivery_isFavorite: Bool,
    delivery_sender: DeliveryDatabaseModel.Sender,
    delivery_route: DeliveryDatabaseModel.Route
  ) {
    self.delivery_id = delivery_id
    self.delivery_goodsPicture = delivery_goodsPicture
    self.delivery_surcharge = delivery_surcharge
    self.delivery_deliveryFee = delivery_deliveryFee
    self.delivery_isFavorite = delivery_isFavorite
    self.delivery_sender = delivery_sender
    self.delivery_route = delivery_route
  }

  init(delivery: Delivery) {
    self.delivery_id = delivery.id
    self.delivery_goodsPicture = delivery.imageURL
    self.delivery_surcharge = delivery.surchargeFee
    self.delivery_deliveryFee = delivery.deliveryFee
    self.delivery_isFavorite = delivery.isFavourite
    self.delivery_sender = DeliveryDatabaseModel.Sender(
      delivery_name: delivery.sender.name,
      delivery_email: delivery.sender.email,
      delivery_phone: delivery.sender.phoneNumber
    )
    self.delivery_route = DeliveryDatabaseModel.Route(
      delivery_start: delivery.route.from,
      delivery_end: delivery.route.to
    )
  }
}

extension DeliveryDatabaseModel {
  struct Sender: Codable {
    var delivery_name: String
    var delivery_email: String
    var delivery_phone: String
  }
  struct Route: Codable {
    var delivery_start: String
    var delivery_end: String
  }
}

extension DeliveryDatabaseModel: DeliveryDTO {
  var isFavourite: Bool? {
    delivery_isFavorite
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

extension DeliveryDatabaseModel.Sender: DeliverySenderDTO {
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

extension DeliveryDatabaseModel.Route: DeliveryRouteDTO {
  var start: String {
    delivery_start
  }

  var end: String {
    delivery_end
  }
}

extension DeliveryDTO {
  func toDeliveryDatabaseModel() -> DeliveryDatabaseModel {
    DeliveryDatabaseModel(
      delivery_id: id,
      delivery_goodsPicture: goodsPicture,
      delivery_surcharge: surcharge,
      delivery_deliveryFee: deliveryFee,
      delivery_isFavorite: isFavourite ?? false,
      delivery_sender: DeliveryDatabaseModel.Sender(
        delivery_name: sender.name,
        delivery_email: sender.email,
        delivery_phone: sender.phone
      ),
      delivery_route: DeliveryDatabaseModel.Route(
        delivery_start: route.start,
        delivery_end: route.end
      )
    )
  }
}
