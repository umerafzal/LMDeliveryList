//
//  DeliveryMapper.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol DeliveryDomainModelMapping {
  func map(deliveries: [DeliveryResponseDTO]) -> [Delivery]
  func map(delivery: DeliveryResponseDTO) -> Delivery
}

final class DeliveryDomainModelMapper: DeliveryDomainModelMapping {
  func map(deliveries: [DeliveryResponseDTO]) -> [Delivery] {
    deliveries.map {
      Delivery(
        id: $0.id,
        imageURL: $0.goodsPicture,
        surchargeFee: $0.surcharge,
        deliveryFee: $0.deliveryFee,
        sender: Delivery.Sender(
          name: $0.sender.name,
          email: $0.sender.email,
          phoneNumber: $0.sender.phone
        ),
        route: Delivery.Route(
          to: $0.route.start,
          from: $0.route.end
        )
      )
    }
  }

  func map(delivery: DeliveryResponseDTO) -> Delivery {
      Delivery(
        id: delivery.id,
        imageURL: delivery.goodsPicture,
        surchargeFee: delivery.surcharge,
        deliveryFee: delivery.deliveryFee,
        sender: Delivery.Sender(
          name: delivery.sender.name,
          email: delivery.sender.email,
          phoneNumber: delivery.sender.phone
        ),
        route: Delivery.Route(
          to: delivery.route.start,
          from: delivery.route.end
        )
      )
  }
}
