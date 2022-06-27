//
//  String+Extension.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation

extension String {
  func removeFormatAmount() -> Decimal {
    let formatter = NumberFormatter()

    formatter.locale = Locale(identifier: "en_US")
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    formatter.decimalSeparator = ","

    return formatter.number(from: self)?.decimalValue ?? 0
  }
}
