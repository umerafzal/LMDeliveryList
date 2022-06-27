//
//  DeliveryListBuilder.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol DeliveryListBuilding {
  func buildDeliveryListScreen() -> DeliveryListViewController
}

extension DependencyContainer: DeliveryListBuilding {
  func buildDeliveryListScreen() -> DeliveryListViewController {
    let router = DeliveryListRouter(deliveryDetailsBuilder: self)
    let interactor = DeliveryListInteractor(repository: resolve(type: DeliveryRepository.self)!)
    let presenter = DeliveryListPresenter(router: router, interactor: interactor, mapper: DeliveryViewModelMapper())
    let vc = DeliveryListViewController(presenter: presenter)
    router.viewController = vc
    presenter.view = vc
    return vc
  }
}
