//
//  DeliveryDetailsViewModelMapper.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation

protocol DeliveryDetailsViewModelMapping {
  func map(delivery: Delivery) -> DeliveryDetailsViewModel
}

final class DeliveryDetailsViewModelMapper: DeliveryDetailsViewModelMapping {
  func map(delivery: Delivery) -> DeliveryDetailsViewModel {
    DeliveryDetailsViewModel(from: delivery.route.from,
                             to: delivery.route.to,
                             goodsToDeliverKey: "Goods To Deliver",
                             goodImageURL: delivery.imageURL,
                             deliveryFeeKey: "Goods Delivery Fee",
                             deliveryFeeValue: delivery.fee,
                             favoriteButtonTitle: "Mark favorite"
    )
  }
}
