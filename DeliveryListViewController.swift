//
//  DeliveryListViewController.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation
import UIKit

protocol DeliveryListView: AnyObject {
  func updateView(deliveries: [Delivery])
}

final class DeliveryListViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .red
  }
}
