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
  private let mapper: DeliveryViewModelMapping

  weak var view: DeliveryListView?

  init(
    router: DeliveryListRouting,
    interactor: DeliveryListInteracting,
    mapper: DeliveryViewModelMapping
  ) {
    self.router = router
    self.interactor = interactor
    self.mapper = mapper
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
        let deliveriesViewModels = self?.mapper.map(deliveries: deliveries)
        self?.view?.updateView(deliveries: deliveriesViewModels ?? [])
      case .failure(let error):
        self?.view?.showError(error: error)
      }
    }
  }
}
