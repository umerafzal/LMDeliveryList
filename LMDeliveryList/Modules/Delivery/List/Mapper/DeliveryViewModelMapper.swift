//
//  DeliveryViewModelMapper.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation

protocol DeliveryViewModelMapping {
  func map(delivery: Delivery) -> DeliveryViewModel
  func map(deliveries: [Delivery]) -> [DeliveryViewModel]
}

final class DeliveryViewModelMapper: DeliveryViewModelMapping {
  func map(deliveries: [Delivery]) -> [DeliveryViewModel] {
    deliveries.map {
      DeliveryViewModel(
        id: $0.id,
        from: $0.route.from,
        to: $0.route.to,
        imageURL: $0.imageURL,
        isFavorite: $0.isFavourite
      )
    }
  }

  func map(delivery: Delivery) -> DeliveryViewModel {
    DeliveryViewModel(
      id: delivery.id,
      from: delivery.route.from,
      to: delivery.route.to,
      imageURL: delivery.imageURL,
      isFavorite: delivery.isFavourite
    )
  }
}
