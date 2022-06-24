//
//  DeliveryDTO.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation


struct DeliveryResponseDTO: Decodable {
  let id: String
  let imageURL: String
  let surchargeFee: String
  let deliveryFee: String
  let sender: DeliveryResponseDTO.Sender
  let route: DeliveryResponseDTO.Route
}

extension DeliveryResponseDTO {
  struct Sender: Decodable {
    let name: String
    let email: String
    let phoneNumber: String
  }
  struct Route: Decodable {
    let to: String
    let from: String
  }
}
