//
//  FunctionsAndHelpers.swift
//  FFUIKit
//
//  Created by Florian Friedrich on 12.12.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

import FFUIKit

public func findFirstResponder() -> UIResponder? {
    var firstResponder: UIResponder? = nil
    if let window = UIApplication.sharedApplication().delegate?.window, let v = window {
        firstResponder = findFirstResponderInView(v)
    }
    return firstResponder
}

public func findFirstResponderInView(view: UIView) -> UIResponder? {
    var firstResponder: UIResponder? = nil
    if view.isFirstResponder() {
        firstResponder = view
    } else {
        for subview in view.subviews {
            if subview.isFirstResponder() {
                firstResponder = subview
                break
            } else {
                firstResponder = findFirstResponderInView(subview)
                if firstResponder != nil { break }
            }
        }
    }
    return firstResponder
}

public func setupView(view: UIView, fullscreenInView superview: UIView, withInsets insets: UIEdgeInsets = UIEdgeInsetsZero) {
    if view.translatesAutoresizingMaskIntoConstraints {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    if view.superview != superview {
        superview.addSubview(view)
    }
    let views = ["view": view]
    let metrics = ["top": insets.top, "left": insets.left, "bottom": insets.bottom, "right": insets.right]
    let formats = ["H:|-(==left)-[view]-(==right)-|", "V:|-(==top)-[view]-(==bottom)-|"]
    let constraints = NSLayoutConstraint.constraintsWithVisualFormats(formats, metrics: metrics, views: views)
    superview.addConstraints(constraints)
}

internal func findForemostViewController() -> UIViewController? {
    var viewController: UIViewController? = nil
    if let vc = UIApplication.sharedApplication().delegate?.window??.rootViewController {
        if let navController = vc as? UINavigationController {
            viewController = navController.viewControllers.last
        }
        if let tabBarController = vc as? UITabBarController {
            viewController = tabBarController.selectedViewController
        }
        if let pageController = vc as? UIPageViewController {
            viewController = pageController.viewControllers?.first
        }
        if viewController == nil {
            viewController = vc
        }
    }
    if let vc = viewController {
        var presentedViewController = vc
        while presentedViewController.presentedViewController != nil {
            presentedViewController = presentedViewController.presentedViewController!
        }
        viewController = presentedViewController
    }
    return viewController
}
