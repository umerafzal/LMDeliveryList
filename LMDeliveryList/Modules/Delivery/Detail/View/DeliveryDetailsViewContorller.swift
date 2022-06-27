//
//  DeliveryDetailsViewContorller.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation
import UIKit

final class DeliveryDetailsViewController: UIViewController {
  private lazy var routeStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [fromLabel, toLabel])
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
  }()

  private lazy var fromLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var toLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var goodsToDeliverKeyLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var deliveryImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  private lazy var deliveryFeeKeyLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var deliveryFeeValueLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var favoriteButton: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      routeStackView,
      goodsToDeliverKeyLabel,
      deliveryImageView,
      deliveryFeeKeyLabel,
      deliveryFeeValueLabel,
      favoriteButton,
      UIView()
    ]
    )
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
  }()


  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  private func configureUI() {
    view.addSubview(mainStackView)
  }

  private func confirgureLayout() {
    mainStackView.pinToSuperView()
  }

}
