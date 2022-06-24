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
    let router = DeliveryListRouter()
    let interactor = DeliveryListInteractor(repository: resolve(type: RemoteFallbackToLocalDeliveryRepository.self)!)
    let presenter = DeliveryListPresenter(router: router, interactor: interactor)
    let vc = DeliveryListViewController(presenter: presenter)
    presenter.view = vc
    return vc
  }
}
