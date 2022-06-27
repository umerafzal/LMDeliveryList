//
//  DeliveryDAO.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

final class DeliveryDAO {
  private init() {}
  static let instance = DeliveryDAO()

  enum StorageKeys: String {
    case deliveries
  }

  func save(deliveriesDTO: [DeliveryDTO]) {
    if var localDeliveriesMap = retrieveDeliveriesInternal() {
      for deliveryDTO in deliveriesDTO {
        if let localDelivery = localDeliveriesMap[deliveryDTO.id] {
          var temporaryDelivery: DeliveryDatabaseModel = localDelivery
          temporaryDelivery = localDelivery
          temporaryDelivery.delivery_id = deliveryDTO.id
          temporaryDelivery.delivery_goodsPicture = deliveryDTO.goodsPicture
          temporaryDelivery.delivery_surcharge = deliveryDTO.surcharge
          temporaryDelivery.delivery_deliveryFee = deliveryDTO.deliveryFee
          temporaryDelivery.delivery_isFavorite = deliveryDTO.isFavourite ?? temporaryDelivery.delivery_isFavorite
          temporaryDelivery.delivery_sender.delivery_name = deliveryDTO.sender.name
          temporaryDelivery.delivery_sender.delivery_email = deliveryDTO.sender.email
          temporaryDelivery.delivery_sender.delivery_phone = deliveryDTO.sender.phone
          temporaryDelivery.delivery_route.delivery_start = deliveryDTO.route.start
          temporaryDelivery.delivery_route.delivery_end = deliveryDTO.route.end
          localDeliveriesMap[temporaryDelivery.id] = temporaryDelivery
        } else {
          localDeliveriesMap[deliveryDTO.id] = deliveryDTO.toDeliveryDatabaseModel()
        }
      }
      saveInternal(models: localDeliveriesMap)
    }
    else {
      var dic: [String: DeliveryDatabaseModel] = [:]
      _ = deliveriesDTO.map { dic[$0.id] = $0.toDeliveryDatabaseModel() }
      saveInternal(models: dic)
    }
  }

  func retrieveDeliveries() -> [DeliveryDatabaseModel]? {
    if let data = UserDefaults.standard.value(forKey: StorageKeys.deliveries.rawValue) as? Data,
       let deliveriesMap = try? JSONDecoder().decode([String: DeliveryDatabaseModel].self, from: data)
    {
      return Array(deliveriesMap.values).sorted(by: { one, two in one.id < two.id })
    }
    return nil
  }

  private func retrieveDeliveriesInternal() -> [String: DeliveryDatabaseModel]? {
    if let data = UserDefaults.standard.value(forKey: StorageKeys.deliveries.rawValue) as? Data,
       let deliveriesMap = try? JSONDecoder().decode([String: DeliveryDatabaseModel].self, from: data)
    {
      return deliveriesMap
    }
    return nil
  }

  private func saveInternal(models: [String: DeliveryDatabaseModel]) {
    let encoded = try? JSONEncoder().encode(models)
    UserDefaults.standard.set(encoded, forKey: StorageKeys.deliveries.rawValue)
  }
}
