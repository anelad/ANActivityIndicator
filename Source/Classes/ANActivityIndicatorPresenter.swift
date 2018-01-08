//
//  ANActivityIndicatorPresenter.swift
//  ANActivityIndicatorViewDemo
//
//  Created by luoyang on 2016/12/6.
//  Copyright © 2016 GTMYang. All rights reserved.
//

import UIKit

/// Class packages information used to display UI blocker.
internal final class ANActivityIndicatorUIBlocker {
    /// Size of activity indicator view.
    let size: CGSize
    
    /// Message displayed under activity indicator view.
    let message: String?
    
    /// Font of message displayed under activity indicator view.
    let messageFont: UIFont
    
    ///Messages margin to Animation.
    let messageTopMargin : CGFloat
    
    private var animation : ANActivityIndicatorAnimation = ANActivityIndicatorAnimationBallSpinFadeLoader()
    
    /// Animation type.
    var animationType: ANActivityIndicatorAnimationType = .ballSpinFadeLoader {
        didSet{
            animation = animationType.toAnimation()
        }
    }
    
    /// Color of activity indicator view.
    let color: UIColor
    
    /// Padding of activity indicator view.
    let padding: CGFloat
    
    /// Display time threshold to actually display UI blocker.
    let displayTimeThreshold: NanosecondInterval
    
    /// Minimum display time of UI blocker.
    let minimumDisplayTime: NanosecondInterval
    
    /**
     Create information package used to display UI blocker.
     
     Appropriate ANActivityIndicatorView.DEFAULT_* values are used for omitted params.
     
     - parameter size:                 size of activity indicator view.
     - parameter message:              message displayed under activity indicator view.
     - parameter messageFont:          font of message displayed under activity indicator view.
     - parameter animation:                 animation type.
     - parameter color:                color of activity indicator view.
     - parameter padding:              padding of activity indicator view.
     - parameter displayTimeThreshold: display time threshold to actually display UI blocker.
     - parameter minimumDisplayTime:   minimum display time of UI blocker.
     
     - returns: The information package used to display UI blocker.
     */
    init(size: CGSize? = nil,
                message: String? = nil,
                messageFont: UIFont? = nil,
                messageTopMargin : CGFloat? = nil,
                animationType: ANActivityIndicatorAnimationType? = nil,
                color: UIColor? = nil,
                padding: CGFloat? = nil,
                displayTimeThreshold: NanosecondInterval? = nil,
                minimumDisplayTime: NanosecondInterval? = nil) {
        self.size = size ?? ANActivityIndicatorView.DEFAULT_BLOCKER_SIZE
        self.message = message ?? ANActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE
        self.messageFont = messageFont ?? ANActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT
        self.messageTopMargin = messageTopMargin ?? ANActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_TOP_MARGIN
        if let animationType = animationType{
            self.animationType = animationType
            self.animation = animationType.toAnimation()
        }
        self.color = color ?? ANActivityIndicatorView.DEFAULT_COLOR
        self.padding = padding ?? ANActivityIndicatorView.DEFAULT_PADDING
        self.displayTimeThreshold = displayTimeThreshold ?? ANActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD
        self.minimumDisplayTime = minimumDisplayTime ?? ANActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME
    }
}

/// Presenter that displays ANActivityIndicatorView as UI blocker.
public final class ANActivityIndicatorPresenter {
    private var showTimer: Timer?
    private var hideTimer: Timer?
    private var isStopAnimatingCalled = false
    private let restorationIdentifier = "ANActivityIndicatorViewContainer"
    
    
    /// Shared instance of `ANActivityIndicatorPresenter`.
    public static let shared = ANActivityIndicatorPresenter()
    
    private init() { }
    
    // MARK: - Public interface
    public func showIndicator(
        _ size: CGSize? = nil,
        message: String? = nil,
        messageFont: UIFont? = nil,
        messageTopMargin : CGFloat? = nil,
        animationType: ANActivityIndicatorAnimationType? = nil,
        color: UIColor? = nil,
        padding: CGFloat? = nil,
        displayTimeThreshold: NanosecondInterval? = nil,
        minimumDisplayTime: NanosecondInterval? = nil) {
        let uiBlocker = ANActivityIndicatorUIBlocker(size: size,
                                        message: message,
                                        messageFont: messageFont,
                                        messageTopMargin : messageTopMargin,
                                        animationType: animationType,
                                        color: color,
                                        padding: padding,
                                        displayTimeThreshold: displayTimeThreshold,
                                        minimumDisplayTime: minimumDisplayTime)
        
        self.startAnimating(uiBlocker)
    }
    
    /**
     Remove UI blocker.
     */
    public func hideIndicator() {
        self.stopAnimating()
    }
    
    
    /**
     Display UI blocker.
     
     - parameter data: Information package used to display UI blocker.
     */
    private final func startAnimating(_ data: ANActivityIndicatorUIBlocker) {
        guard showTimer == nil else { return }
        isStopAnimatingCalled = false
        showTimer = scheduledTimer(data.displayTimeThreshold, selector: #selector(showTimerFired(_:)), data: data)
    }
    
    /**
     Remove UI blocker.
     */
    private final func stopAnimating() {
        isStopAnimatingCalled = true
        guard hideTimer == nil else { return }
        hide()
    }
    
    // MARK: - Timer events
    
    @objc private func showTimerFired(_ timer: Timer) {
        guard let activityData = timer.userInfo as? ANActivityIndicatorUIBlocker else { return }
        show(with: activityData)
    }
    
    @objc private func hideTimerFired(_ timer: Timer) {
        hideTimer?.invalidate()
        hideTimer = nil
        if isStopAnimatingCalled {
            hide()
        }
    }
    
    // MARK: - Helpers
    
    private func show(with activityData: ANActivityIndicatorUIBlocker) {
        let activityContainer: UIView = UIView(frame: UIScreen.main.bounds)
        
        activityContainer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityContainer.restorationIdentifier = restorationIdentifier
        
        let actualSize = activityData.size
        let activityIndicatorView = ANActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: actualSize.width, height: actualSize.height),
            animationType: activityData.animationType,
            color: activityData.color,
            padding: activityData.padding)
        
        activityIndicatorView.center = activityContainer.center
        activityIndicatorView.startAnimating()
        activityContainer.addSubview(activityIndicatorView)
        
        if let message = activityData.message , !message.isEmpty {
            let label = UILabel()
            
            label.textAlignment = .center
            label.text = message
            label.font = activityData.messageFont
            label.textColor = activityIndicatorView.color
            label.numberOfLines = 0
            label.sizeToFit()
            if label.bounds.size.width > activityContainer.bounds.size.width {
                let maxWidth = activityContainer.bounds.size.width - 16
                
                label.bounds.size = NSString(string: message).boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil).size
            }
            label.center = CGPoint(
                x: activityIndicatorView.center.x,
                y: activityIndicatorView.center.y + actualSize.height/2 + label.bounds.size.height / 2 + activityData.messageTopMargin)
            activityContainer.addSubview(label)
        }
        
        hideTimer = scheduledTimer(activityData.minimumDisplayTime, selector: #selector(hideTimerFired(_:)), data: nil)
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        keyWindow.addSubview(activityContainer)
    }
    
    private func hide() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        for item in keyWindow.subviews
            where item.restorationIdentifier == restorationIdentifier {
                item.removeFromSuperview()
        }
        showTimer?.invalidate()
        showTimer = nil
    }
    
    private func scheduledTimer(_ timeInterval: NanosecondInterval, selector: Selector, data: ANActivityIndicatorUIBlocker?) -> Timer {
        return Timer.scheduledTimer(timeInterval: Double(timeInterval) / 1000,
                                    target: self,
                                    selector: selector,
                                    userInfo: data,
                                    repeats: false)
    }
}

public typealias NanosecondInterval = TimeInterval
