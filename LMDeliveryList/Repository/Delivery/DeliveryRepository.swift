//
//  DeliveryRepository.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryRepository {
  func fetchDeliveries(startIndex: Int, offset: Int, completion: @escaping (Result<[Delivery], Error>) -> Void)
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
  func fetchDeliveries(startIndex: Int, offset: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {

  }
}
