//
//  DeliveryinformationCell.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation
import UIKit

final class DeliveryCell: UITableViewCell {

  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      deliveryImageView,
      routeStackView
    ])
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var deliveryImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  private lazy var routeStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      fromLabel,
      toLabel
    ])
    stackView.axis = .vertical
    stackView.spacing = 8
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

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayoutConstraints()
    setupLayout()
  }

  @available(*, unavailable, message: "Not available, use init(style:_reuseIdentifier:_)")
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayoutConstraints() {
    contentView.addSubview(mainStackView)
  }

  func setupLayout() {
    backgroundColor = .clear
    mainStackView.pinToSuperView()
    deliveryImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }

  func update(model: DeliveryViewModel) {
    self.fromLabel.text = "from: " + model.from
    self.toLabel.text = "to:" + model.to
    self.deliveryImageView.downloaded(from: model.imageURL)
  }
}