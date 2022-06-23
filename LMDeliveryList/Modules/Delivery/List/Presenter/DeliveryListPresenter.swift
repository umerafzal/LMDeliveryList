//
//  DeliveryListPresenter.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryListPresenting {
  func viewDidLoad()
}

final class DeliveryListPresenter {
  private let router: DeliveryListRouting
  private let interactor: DeliveryListInteracting

  weak var view: DeliveryListView?

  init(
    router: DeliveryListRouting,
    interactor: DeliveryListInteracting
  ) {
    self.router = router
    self.interactor = interactor
  }
}

extension DeliveryListPresenter: DeliveryListPresenting {
  func viewDidLoad() {
    view?.updateView(deliveries: [])
  }
}
