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
        imageURL: $0.imageURL,
        surchargeFee: $0.surchargeFee,
        deliveryFee: $0.deliveryFee,
        sender: Delivery.Sender(
          name: $0.sender.name,
          email: $0.sender.email,
          phoneNumber: $0.sender.phoneNumber
        ),
        route: Delivery.Route(
          to: $0.route.to,
          from: $0.route.from
        )
      )
    }
  }

  func map(delivery: DeliveryResponseDTO) -> Delivery {
      Delivery(
        id: delivery.id,
        imageURL: delivery.imageURL,
        surchargeFee: delivery.surchargeFee,
        deliveryFee: delivery.deliveryFee,
        sender: Delivery.Sender(
          name: delivery.sender.name,
          email: delivery.sender.email,
          phoneNumber: delivery.sender.phoneNumber
        ),
        route: Delivery.Route(
          to: delivery.route.to,
          from: delivery.route.from
        )
      )
  }
}
