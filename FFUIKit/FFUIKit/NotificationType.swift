//
//  NotificationType.swift
//  FFUIKit
//
//  Created by Florian Friedrich on 14/03/16.
//  Copyright © 2016 Florian Friedrich. All rights reserved.
//

import UIKit

public enum NotificationType<NotificationView: NotificationViewType where NotificationView: UIView> {
    case Default // White
    case Warning // Yellow
    case Failure // Red
    case Success // Green
    case Info    // Blue
    case Custom(viewConfiguration: NotificationView -> Void) // Whatever you like
    
    internal func configureNotificationView(view: NotificationView) {
        let backgroundColor: UIColor
        let textColor: UIColor
        let alpha: CGFloat = 0.85
        switch self {
        case .Default:
            backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(alpha)
            textColor = .blackColor()
        case .Warning:
            backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(alpha)
            textColor = UIColor.blackColor()
        case .Failure:
            backgroundColor = UIColor.redColor().colorWithAlphaComponent(alpha)
            textColor = UIColor.whiteColor()
        case .Success:
            backgroundColor = UIColor.greenColor().colorWithAlphaComponent(alpha)
            textColor = UIColor.blackColor()
        case .Info:
            backgroundColor = UIColor.blueColor().colorWithAlphaComponent(alpha)
            textColor = UIColor.whiteColor()
        case .Custom(_):
            backgroundColor = UIColor.clearColor()
            textColor = UIColor.clearColor()
        }
        
        if case let NotificationType.Custom(configuration) = self {
            configuration(view)
        } else {
            view.backgroundColor = backgroundColor
            if let textNotificationView = view as? TextNotificationView {
                textNotificationView.textLabel.textColor = textColor
            }
        }
    }
}