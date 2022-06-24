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
    if let localDeliveries = retrieveDeliveries() {
      var deliveriesToSave: [DeliveryDTO] = []
      for deliveryDTO in deliveriesDTO {
        var existingRecordUpdated = false
        var temporaryDelivery: DeliveryDatabaseModel!
        for localDelivery in localDeliveries {
          if deliveryDTO.id == localDelivery.id {
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
            existingRecordUpdated = true
          }
        }
        if existingRecordUpdated {
          deliveriesToSave.append(temporaryDelivery)
        } else {
          deliveriesToSave.append(deliveryDTO)
        }
      }
      let models = deliveriesToSave.map { $0.toDeliveryDatabaseModel() }
      saveInternal(models: models)
    }
    else {
      let models = deliveriesDTO.map { $0.toDeliveryDatabaseModel() }
      saveInternal(models: models)
    }
  }

  func retrieveDeliveries() -> [DeliveryDatabaseModel]? {
    if let data = UserDefaults.standard.value(forKey: StorageKeys.deliveries.rawValue) as? Data,
       let deliveries = try? JSONDecoder().decode([DeliveryDatabaseModel].self, from: data)
    {
      return deliveries
    }
    return nil
  }

  private func saveInternal(models: [DeliveryDatabaseModel]) {
    let encoded = try? JSONEncoder().encode(models)
    UserDefaults.standard.set(encoded, forKey: StorageKeys.deliveries.rawValue)
  }
}
