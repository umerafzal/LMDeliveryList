//
//  DeliveryWebService.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation

final class DeliveryWebService: DeliveryService {

  private let client: APIClient

  init(client: APIClient) {
    self.client = client
  }
  
  func fetchDeliveries(offset: Int, limit: Int, completion: @escaping (Result<[DeliveryDTO], Error>) -> Void) {
    let resource = DeliveryResource.fetchDeliveries(offset: offset, limit: limit)
    self.client.executeRequest(parameters: resource) { [unowned self] result in
      switch result {
      case .success(let response):
        guard let data = response.jsonResponse else {
          return completion(.failure(NSError()))
        }
        let deliveriesDTOs: [DeliveryResponse]
        do {
          deliveriesDTOs = try JSONDecoder().decode([DeliveryResponse].self, from: data)
        }
        catch let error {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
