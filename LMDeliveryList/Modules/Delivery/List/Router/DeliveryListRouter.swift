//
//  DeliveryListRouter.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation
import UIKit

protocol DeliveryListRouting {
  func navigateToDeliveryDetailsScreen(delivery: Delivery)
}

final class DeliveryListRouter {
  private let deliveryDetailsBuilder: DeliveryDetailsBuilding

  weak var viewController: UIViewController?

  init(deliveryDetailsBuilder: DeliveryDetailsBuilding) {
    self.deliveryDetailsBuilder = deliveryDetailsBuilder
  }
}

extension DeliveryListRouter: DeliveryListRouting {
  func navigateToDeliveryDetailsScreen(delivery: Delivery) {
    let vc = deliveryDetailsBuilder.buildDeliveryDetailsScreen(delivery: delivery)
    viewController?.navigationController?.pushViewController(vc, animated: true)
  }
}
