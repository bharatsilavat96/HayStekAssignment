//
//  CustomHeaderView.swift
//  HayStek
//
//  Created by Bharat Shilavat on 10/04/25.
//

import Foundation
import UIKit


class FlashSaleHeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.7)
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "02:59:23"
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let seeAllLabel: UILabel = {
        let label = UILabel()
        label.text = "See all"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // MARK: - Initializer with Configurable Params
    
    init(title: String, showTimer: Bool) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupViews(showTimer: showTimer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews(showTimer: true) // Default to showing the timer if not specified
    }

    // MARK: - Setup

    private func setupViews(showTimer: Bool) {
        leftStack.addArrangedSubview(titleLabel)
        if showTimer {
            leftStack.addArrangedSubview(timerLabel)
        }

        rightStack.addArrangedSubview(seeAllLabel)
        rightStack.addArrangedSubview(arrowImageView)

        mainStack.addArrangedSubview(leftStack)
        mainStack.addArrangedSubview(rightStack)

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
