//
//  DeliveryListViewController.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import Foundation
import UIKit

protocol DeliveryListView: AnyObject {
  func updateView(deliveries: [DeliveryViewModel])
  func showError(error: Error)
}

final class DeliveryListViewController: UIViewController {
  private let presenter: DeliveryListPresenting
  private var deliveries: [DeliveryViewModel]

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()

  init(presenter: DeliveryListPresenting) {
    self.presenter = presenter
    self.deliveries = []
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    presenter.onViewDidLoad()
  }

  func configureUI() {
    view.addSubview(tableView)
    confirgureLayout()
  }

  func confirgureLayout() {
    tableView.pinToSuperView()
  }
}

extension DeliveryListViewController: DeliveryListView {
  func updateView(deliveries: [DeliveryViewModel]) {
    self.deliveries = deliveries
    tableView.reloadData()
  }

  func showError(error: Error) {
    // show error
  }
}

extension DeliveryListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.deliveries.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = DeliveryCell(style: .default, reuseIdentifier: "\(DeliveryCell.self)")
    cell.update(model: self.deliveries[indexPath.row])
    return cell
  }
}


