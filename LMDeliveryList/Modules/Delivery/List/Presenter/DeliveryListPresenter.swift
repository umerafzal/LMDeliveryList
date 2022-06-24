//
//  DeliveryListPresenter.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryListPresenting {
  func onViewDidLoad()
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
  func onViewDidLoad() {
    fetchDeleiveries()
  }

  func fetchDeleiveries(offset: Int = 0) {
    interactor.fetchDeliveries(offset: 0) { [weak self] result in
      switch result {
      case .success(let deliveries):
        self?.view?.updateView(deliveries: deliveries)
      case .failure(let error):
        self?.view?.showError(error: error)
      }
    }
  }
}
