//
//  DeliveryListInteractor.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryListInteracting {
  func fetchDeliveries(offset: Int, completion: @escaping (Result<[Delivery], Error>) -> Void)
}

final class DeliveryListInteractor: DeliveryListInteracting {

  private let repository: DeliveryRepository
  private let limit = 20

  init(repository: DeliveryRepository) {
    self.repository = repository
  }

  func fetchDeliveries(offset: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {
    repository.fetchAll(offset: offset, limit: limit, completion: completion)
  }
}
