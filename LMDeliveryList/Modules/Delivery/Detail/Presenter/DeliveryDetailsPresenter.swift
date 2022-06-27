//
//  DeliveryDetailsPresenter.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation

protocol DeliveryDetailsPresenting {
  func onViewDidLoad()
  func onFavoriteButtonPressed()
}

final class DeliveryDetailsPresenter {
  weak var view: DeliveryDetailsView?

  private let delivery: Delivery
  private let mapper: DeliveryDetailsViewModelMapping

  init(
    selectedDeliveryDetails: Delivery,
    mapper: DeliveryDetailsViewModelMapping
  ) {
    self.delivery = selectedDeliveryDetails
    self.mapper = mapper
  }
}

extension DeliveryDetailsPresenter: DeliveryDetailsPresenting {
  func onViewDidLoad() {
    let model = self.mapper.map(delivery: delivery)
    view?.updateView(viewModel: model)
  }

  func onFavoriteButtonPressed() {

  }
}
