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

  static let instance = DependencyContainer()

  private init() {
    registerDeliveryDependencies()
  }

  func registerDeliveryDependencies() {
    register(type: DeliveryWebService.self) { _ in
      DeliveryWebService()
    }
    register(type: DeliveryLocalService.self) { _ in
      DeliveryLocalService()
    }
    register(type: RemoteFallbackToLocalDeliveryRepository.self) { container in
      RemoteFallbackToLocalDeliveryRepository(
        remote: container.resolve(type: DeliveryWebService.self)!,
        local: container.resolve(type: DeliveryLocalService.self)!
      )
    }
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
