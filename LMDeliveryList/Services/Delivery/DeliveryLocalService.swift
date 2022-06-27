//
//  DeliveryLocalService.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

final class DeliveryLocalService: DeliveryService {

  // UserDefaults for storage for assignment purpose

  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[DeliveryDTO], Error>) -> Void) {
    if let deliveries = DeliveryDAO.instance.retrieveDeliveries() {
      completion(.success(deliveries))
    } else {
      completion(.failure(NSError(domain: "DATABASE.ERROR", code: -800, userInfo: nil)))
    }
  }

  func update(delivery: Delivery) {
    DeliveryDAO.instance.save(deliveriesDTO: [DeliveryDatabaseModel(delivery: delivery)])
  }
}
