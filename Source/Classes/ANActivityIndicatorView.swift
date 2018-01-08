//
//  ANActivityIndicatorView.swift
//  ANActivityIndicatorViewDemo
//
//  Created by luoyang on 2016/12/6.
//  Copyright © 2016 GTMYang. All rights reserved.
//

import UIKit


/// Activity indicator view with nice animations
public final class ANActivityIndicatorView: UIView {
    
    /// Default color. Default value is UIColor.whiteColor().
    internal static var DEFAULT_COLOR = UIColor.white
    
    /// Default padding. Default value is 0.
    internal static var DEFAULT_PADDING: CGFloat = 0
    
    /// Default size of activity indicator view in UI blocker. Default value is 60x60.
    internal static var DEFAULT_BLOCKER_SIZE = CGSize(width: 60, height: 60)
    
    /// Default display time threshold to actually display UI blocker. Default value is 0 ms.
    internal static var DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD : NanosecondInterval = 0
    
    /// Default minimum display time of UI blocker. Default value is 0 ms.
    internal static var DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME : NanosecondInterval = 0
    
    /// Default message displayed in UI blocker. Default value is nil.
    internal static var DEFAULT_BLOCKER_MESSAGE: String? = nil
    
    /// Default font of message displayed in UI blocker. Default value is bold system font, size 20.
    internal static var DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 20)
    
    /// Default top margin of message displayed in UI blocker. Default value is 8
    internal static var DEFAULT_BLOCKER_MESSAGE_TOP_MARGIN : CGFloat = 8
    
    ///Animation of the indicator. Set by animationType. Do not set manually.
    private var animation : ANActivityIndicatorAnimation = ANActivityIndicatorAnimationBallSpinFadeLoader()
    
    /// Animation type.
    public var animationType: ANActivityIndicatorAnimationType = .ballSpinFadeLoader {
        didSet{
            animation = animationType.toAnimation()
        }
    }
    
    /// Color of activity indicator view.
    @IBInspectable public var color: UIColor = ANActivityIndicatorView.DEFAULT_COLOR
    
    /// Padding of activity indicator view.
    @IBInspectable public var padding: CGFloat = ANActivityIndicatorView.DEFAULT_PADDING
    
    /// Current status of animation, read-only.
    @available(*, deprecated: 3.1)
    public var animating: Bool { return isAnimating }
    
    /// Current status of animation, read-only.
    public private(set) var isAnimating: Bool = false
    
    /**
     Returns an object initialized from data in a given unarchiver.
     self, initialized using the data in decoder.
     
     - parameter decoder: an unarchiver object.
     
     - returns: self, initialized using the data in decoder.
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.animation = animationType.toAnimation()
        backgroundColor = UIColor.clear
        isHidden = true
    }
    
    /**
     Create a activity indicator view.
     
     Appropriate ANActivityIndicatorView.DEFAULT_* values are used for omitted params.
     
     - parameter frame:   view's frame.
     - parameter type:    animation type.
     - parameter color:   color of activity indicator view.
     - parameter padding: padding of activity indicator view.
     
     - returns: The activity indicator view.
     */
    public init(frame: CGRect, animationType: ANActivityIndicatorAnimationType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        super.init(frame: frame)
        if let animationType = animationType{
            self.animationType = animationType
            self.animation = animationType.toAnimation()
        }
        self.color = color ?? ANActivityIndicatorView.DEFAULT_COLOR
        self.padding = padding ?? ANActivityIndicatorView.DEFAULT_PADDING
        isHidden = true
    }
    
    // Fix issue #62
    // Intrinsic content size is used in autolayout
    // that causes mislayout when using with MBProgressHUD.
    /**
     Returns the natural size for the receiving view, considering only properties of the view itself.
     
     A size indicating the natural size for the receiving view based on its intrinsic properties.
     
     - returns: A size indicating the natural size for the receiving view based on its intrinsic properties.
     */
    public override var intrinsicContentSize : CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }
    
    /**
     Start animating.
     */
    public final func startAnimating() {
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }
    
    /**
     Stop animating.
     */
    public final func stopAnimating() {
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }
    
    
    // MARK: Privates
    
    private final func setUpAnimation() {
        var animationRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(padding, padding, padding, padding))
        let minEdge = min(animationRect.width, animationRect.height)
        
        layer.sublayers = nil
        animationRect.size = CGSize(width: minEdge, height: minEdge)
        animation.setUpAnimation(in: layer, size: animationRect.size, color: color)
    }
}
