//
//  DeliveryResource.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

enum DeliveryResource: ResourceParameters {
  case fetchDeliveries(offset: Int, limit: Int)

  var path: String {
    switch self {
    case .fetchDeliveries(let offset, let limit):
      return "deliveries?offset=\(offset)&limit=\(limit)"
    }
  }

  var httpMethod: HTTPMethod {
    switch self {
    case .fetchDeliveries:
      return .GET
    }
  }

  var body: [String : Any]? {
    switch self {
    case .fetchDeliveries:
      return nil
    }
  }

  var headers: [String : String]? {
    switch self {
    case .fetchDeliveries:
      return nil
    }
  }

  var bodyFormat: HttpBodyFormat {
    switch self {
    default:
        return .URLFormData
    }
  }
}
