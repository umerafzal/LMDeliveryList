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

  private var delivery: Delivery
  private let mapper: DeliveryDetailsViewModelMapping
  private let repository: DeliveryRepository
  private var favoriteValue: Bool

  init(
    selectedDeliveryDetails: Delivery,
    mapper: DeliveryDetailsViewModelMapping,
    repository: DeliveryRepository
  ) {
    self.delivery = selectedDeliveryDetails
    self.mapper = mapper
    self.repository = repository
    favoriteValue = delivery.isFavourite
  }
}

extension DeliveryDetailsPresenter: DeliveryDetailsPresenting {
  func onViewDidLoad() {
    let model = self.mapper.map(delivery: delivery)
    view?.updateView(viewModel: model)
  }

  func onFavoriteButtonPressed() {
    favoriteValue = !favoriteValue
    self.delivery = Delivery(
      id: delivery.id,
      imageURL: delivery.imageURL,
      surchargeFee: delivery.surchargeFee,
      deliveryFee: delivery.deliveryFee,
      isFavourite: favoriteValue,
      sender: delivery.sender,
      route: delivery.route
    )
    let model = self.mapper.map(delivery: self.delivery)
    view?.updateView(viewModel: model)
    repository.update(delivery: self.delivery)
  }
}
