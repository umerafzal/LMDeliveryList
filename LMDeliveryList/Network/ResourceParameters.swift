//
//  ResourceParameters.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
}

enum HttpBodyFormat {
  case JSON
  case URLFormData
}

protocol ResourceParameters {
  var path: String { get }
  var httpMethod: HTTPMethod { get }
  var body: [String: Any]? { get }
  var headers: [String: String]? { get }
  var bodyFormat: HttpBodyFormat { get }
}
