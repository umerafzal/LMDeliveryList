//
//  DeliveryMapper.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol DeliveryDomainModelMapping {
  func map(deliveries: [DeliveryResponseDTO]) -> [Delivery]
  func map(deliveries: DeliveryResponseDTO) -> Delivery
}
