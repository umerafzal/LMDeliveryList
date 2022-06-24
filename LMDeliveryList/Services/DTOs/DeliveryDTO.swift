//
//  DeliveryDTO.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation


struct DeliveryResponseDTO: Decodable {
  let id: String
  let goodsPicture: String
  let surcharge: String
  let deliveryFee: String
  let sender: DeliveryResponseDTO.Sender
  let route: DeliveryResponseDTO.Route
}

extension DeliveryResponseDTO {
  struct Sender: Decodable {
    let name: String
    let email: String
    let phone: String
  }
  struct Route: Decodable {
    let start: String
    let end: String
  }
}
