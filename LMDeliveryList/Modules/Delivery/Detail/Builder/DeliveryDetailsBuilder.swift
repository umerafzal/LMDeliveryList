//
//  DeliveryDetailsBuilder.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation

protocol DeliveryDetailsBuilding {
  func buildDeliveryDetailsScreen(delivery: Delivery) -> DeliveryDetailsViewController
}

extension DependencyContainer: DeliveryDetailsBuilding {
  func buildDeliveryDetailsScreen(delivery: Delivery) -> DeliveryDetailsViewController {
    let presenter = DeliveryDetailsPresenter(
      selectedDeliveryDetails: delivery,
      mapper: DeliveryDetailsViewModelMapper()
    )
    let vc = DeliveryDetailsViewController(presenter: presenter)
    presenter.view = vc
    return vc
  }
}
