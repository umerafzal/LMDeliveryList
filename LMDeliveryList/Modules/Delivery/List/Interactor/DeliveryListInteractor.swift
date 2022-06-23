//
//  DeliveryListInteractor.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryListInteracting {

}

final class DeliveryListInteractor: DeliveryListInteracting {
  private let repository: DeliveryRepository

  init(repository: DeliveryRepository) {
    self.repository = repository
  }
}
