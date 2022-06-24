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

protocol DeliveryService {
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[DeliveryDTO], Error>) -> Void)
}

final class DeliveryRepositoryImpl {
  private let remote: DeliveryService
  private let local: DeliveryService

  init(
    remote: DeliveryService,
    local: DeliveryService
  ) {
    self.remote = remote
    self.local = local
  }
}

extension DeliveryRepositoryImpl: DeliveryRepository {
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {
    
  }
}
