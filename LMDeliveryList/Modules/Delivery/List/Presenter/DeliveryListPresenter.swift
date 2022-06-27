//
//  DeliveryListPresenter.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryListPresenting {
  func onViewDidAppear()
  func onItemSelected(index: Int)
}

final class DeliveryListPresenter {
  private let router: DeliveryListRouting
  private let interactor: DeliveryListInteracting
  private let mapper: DeliveryViewModelMapping

  private var deliveries: [Delivery] = []

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
  func onViewDidAppear() {
    fetchDeleiveries()
  }

  func fetchDeleiveries(offset: Int = 0) {
    interactor.fetchDeliveries(offset: 0) { [weak self] result in
      switch result {
      case .success(let deliveries):
        self?.deliveries = deliveries
        let deliveriesViewModels = self?.mapper.map(deliveries: deliveries)
        self?.view?.updateView(deliveries: deliveriesViewModels ?? [])
      case .failure(let error):
        self?.view?.showError(error: error)
      }
    }
  }

  func onItemSelected(index: Int) {
    router.navigateToDeliveryDetailsScreen(delivery: deliveries[index])
  }
}
