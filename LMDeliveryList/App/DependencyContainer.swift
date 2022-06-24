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
    registerAPIClient()
    registerDeliveryDependencies()
  }

  private func registerAPIClient() {
    register(type: APIClient.self) { _ in
      APIClientImpl(
        requestEncoder: RequestEncoderImpl(),
        configuration: .ephemeral
      )
    }
  }

  private func registerDeliveryDependencies() {
    registerDeliveryServices()
    registerDeliveryRepository()
  }

  private func registerDeliveryServices() {
    register(type: DeliveryDomainModelMapping.self) { _ in
      DeliveryDomainModelMapper()
    }
    register(type: DeliveryWebService.self) { container in
      DeliveryWebService(
        client: container.resolve(type: APIClient.self)!
        )
    }
    register(type: DeliveryLocalService.self) { _ in
      DeliveryLocalService()
    }
  }

  private func registerDeliveryRepository() {
    register(type: DeliveryRepository.self) { container in
      DeliveryRepositoryImpl(
        remote: container.resolve(type: DeliveryWebService.self)!,
        local: container.resolve(type: DeliveryLocalService.self)!,
        mapper: container.resolve(type: DeliveryDomainModelMapping.self)!
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
