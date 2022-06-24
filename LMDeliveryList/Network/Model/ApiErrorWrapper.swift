//
//  ApiErrorWrapper.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

struct ApiErrorWrapper: Error {
  let httpResponse: HTTPURLResponse?
  let httpError: Error
  let jsonResponse: Data?
}
