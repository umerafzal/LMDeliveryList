//
//  DeliveryRepository.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryRepository {
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void)
}

final class RemoteFallbackToLocalDeliveryRepository {
  private let remote: DeliveryWebService
  private let local: DeliveryLocalService

  init(
    remote: DeliveryWebService,
    local: DeliveryLocalService
  ) {
    self.remote = remote
    self.local = local
  }
}

extension RemoteFallbackToLocalDeliveryRepository: DeliveryRepository {
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {
    remote.fetchDeliveries(offset: offset, limit: limit) { result in
      
    }
  }
}
