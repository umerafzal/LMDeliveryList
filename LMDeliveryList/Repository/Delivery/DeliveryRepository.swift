//
//  DeliveryRepository.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

protocol DeliveryRepository {
  func fetchAll(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void)
  func update(delivery: Delivery)
}

protocol DeliveryService {
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[DeliveryDTO], Error>) -> Void)
  func update(delivery: Delivery)
}

final class DeliveryRepositoryImpl {
  private let remote: DeliveryService
  private let local: DeliveryService
  private let mapper: DeliveryDomainModelMapping

  init(
    remote: DeliveryService,
    local: DeliveryService,
    mapper: DeliveryDomainModelMapping
  ) {
    self.remote = remote
    self.local = local
    self.mapper = mapper
  }
}

extension DeliveryRepositoryImpl: DeliveryRepository {

  func update(delivery: Delivery) {
    local.update(delivery: delivery)
  }

  func fetchAll(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {
    local.fetchDeliveries(offset: offset, limit: limit) { [weak self] result in
      switch result {
      case .success(let deliveriesDTO):
        print("Local Data")
        let deliveries = self?.mapper.map(deliveries: deliveriesDTO)
        completion(.success(deliveries ?? []))
      case .failure(let error):
        print(error)
        self?.remote.fetchDeliveries(offset: offset, limit: limit) { remoteResult in
          switch remoteResult {
          case .success(let deliveriesDTO):
            print("Remote Data")
            let deliveries = self?.mapper.map(deliveries: deliveriesDTO)
            completion(.success(deliveries ?? []))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }
    }
  }
}
