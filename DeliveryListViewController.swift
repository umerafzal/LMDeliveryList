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
  private let presenter: DeliveryListPresenting

  init(presenter: DeliveryListPresenting) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    presenter.onViewDidLoad()
  }
}

extension DeliveryListViewController: DeliveryListView {
  func updateView(deliveries: [Delivery]) {

  }
}
