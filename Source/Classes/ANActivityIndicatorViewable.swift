//
//  NVActivityIndicatorViewable.swift
//  NVActivityIndicatorViewDemo
//
//  Created by luoyang on 2016/12/6.
//  Copyright © 2016 GTMYang. All rights reserved.
//

import UIKit

//UIViewController extension to let users show/hide indicator easily.
public extension UIViewController {
    
    /**
     Display UI blocker.
     
     Appropriate NVActivityIndicatorView.DEFAULT_* values are used for omitted params.
     
     - parameter size:                 size of activity indicator view.
     - parameter message:              message displayed under activity indicator view.
     - parameter messageFont:          font of message displayed under activity indicator view.
     - parameter type:                 animation type.
     - parameter color:                color of activity indicator view.
     - parameter padding:              padding of activity indicator view.
     - parameter displayTimeThreshold: display time threshold to actually display UI blocker.
     - parameter minimumDisplayTime:   minimum display time of UI blocker.
     */
    public final func showIndicator(
        _ size: CGSize? = nil,
        message: String? = nil,
        messageFont: UIFont? = nil,
        animationType: ANActivityIndicatorAnimationType? = nil,
        color: UIColor? = nil,
        padding: CGFloat? = nil,
        displayTimeThreshold: Int? = nil,
        minimumDisplayTime: Int? = nil) {
        ANActivityIndicatorPresenter.shared.showIndicator(size, message: message, messageFont: messageFont, animationType: animationType, color: color, padding: padding, displayTimeThreshold: displayTimeThreshold, minimumDisplayTime: minimumDisplayTime)
    }
    
    /**
     Remove UI blocker.
     */
    public final func hideIndicator() {
        ANActivityIndicatorPresenter.shared.hideIndicator()
    }
}
