//
//  DeliveryDetailsViewContorller.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 27/06/2022.
//

import Foundation
import UIKit

protocol DeliveryDetailsView: AnyObject {
  func updateView(viewModel: DeliveryDetailsViewModel)
}

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

  private lazy var favoriteButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
    return button
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

  private let presenter: DeliveryDetailsPresenting

  init(presenter: DeliveryDetailsPresenting) {
    self.presenter = presenter
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

  private func configureUI() {
    view.addSubview(mainStackView)
  }

  private func confirgureLayout() {
    mainStackView.pinToSuperView()
  }

}

extension DeliveryDetailsViewController: DeliveryDetailsView {
  func updateView(viewModel: DeliveryDetailsViewModel) {
    fromLabel.text = viewModel.from
    toLabel.text = viewModel.to
    goodsToDeliverKeyLabel.text = viewModel.goodsToDeliverKey
    deliveryImageView.downloaded(from: viewModel.goodImageURL)
    deliveryFeeKeyLabel.text = viewModel.deliveryFeeKey
    deliveryFeeValueLabel.text = viewModel.deliveryFeeValue
  }
}

extension DeliveryDetailsViewController {
  @objc
  func favoriteAction() {

  }
}
