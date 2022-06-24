//
//  DeliveryWebService.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

final class DeliveryWebService: DeliveryRepository {
  private let client: APIClient
  private let mapper: DeliveryDomainModelMapping

  init(
    client: APIClient,
    deliveryDomainModelMapper: DeliveryDomainModelMapping
  ) {
    self.client = client
    self.mapper = deliveryDomainModelMapper
  }
  
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[Delivery], Error>) -> Void) {
    let resource = DeliveryResource.fetchDeliveries(offset: offset, limit: limit)
    self.client.executeRequest(parameters: resource) { result in
      switch result {
      case .success(let response):
        print(response)
      case .failure(let error):
        print(error)
      }
    }
  }
}
