//
//  NotificationView.swift
//  FFUIKit
//
//  Copyright 2016 Florian Friedrich
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

open class NotificationView: UIView {

    public let backgroundView = UIView()
    public let contentView = UIView()

    private(set) internal var contentViewTopConstraint: NSLayoutConstraint!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    private final func initialize() {
        backgroundColor = .clear
        backgroundView.setupFullscreen(in: self)
        contentView.enableAutoLayout()
        addSubview(contentView)
        let otherConstraints: [NSLayoutConstraint]
        if #available(iOS 11.0, *) {
            contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
            otherConstraints = [
                contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        } else if #available(iOS 9.0, *) {
            contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
            otherConstraints = [
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        } else {
            contentViewTopConstraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 0, constant: 0)
            otherConstraints = [
                NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 0, constant: 0),
                NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0, constant: 0),
                NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0, constant: 0)
            ]
        }
        contentViewTopConstraint.isActive = true
        otherConstraints.activate()
    }
    
    open func configure(for style: NotificationStyle) {
        backgroundView.backgroundColor = style.suggestedBackgroundColor
    }

    internal func _willAppear(animated: Bool) { willAppear(animated: animated) }
    internal func _didAppear(animated: Bool) { didAppear(animated: animated) }
    internal func _willDisappear(animated: Bool) { willDisappear(animated: animated) }
    internal func _didDisappear(animated: Bool) { didDisappear(animated: animated) }
    internal func _didReceiveTouch(sender: Any?) { didReceiveTouch(sender: sender) }

    // MARK: - Methods for subclasses
    open func willAppear(animated: Bool) { /* For Subclasses */ }
    open func didAppear(animated: Bool) { /* For Subclasses */ }
    open func willDisappear(animated: Bool) { /* For Subclasses */ }
    open func didDisappear(animated: Bool) { /* For Subclasses */ }
    open func didReceiveTouch(sender: Any?) { /* For Subclasses */ }
}
