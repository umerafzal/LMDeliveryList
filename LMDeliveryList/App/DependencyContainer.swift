//
//  DependencyContainer.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

typealias FactoryClosure = (DependencyContainer) -> AnyObject

final class DependencyContainer {
  var services: [String:FactoryClosure] = [:]

  static let shared = DependencyContainer()

  private init() {

  }
}

extension DependencyContainer {
  func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure) {
    services["\(type)"] = factoryClosure
  }

  func resolve<Service>(type: Service.Type) -> Service? {
    return services["\(type)"]?(self) as? Service
  }

}
