//
//  ANActivityIndicatorDelegate.swift
//  ANActivityIndicatorViewDemo
//
//  Created by Arda Oğul Üçpınar on 2018/01/07.
//  Copyright © 2016 Arda Oğul Üçpınar. All rights reserved.
//

import UIKit

///Protocol for animations. Can bu used with classes only.
public protocol ANActivityIndicatorAnimation : AnyObject {
    func setUpAnimation(in layer:CALayer, size: CGSize, color: UIColor)
    init()
}

///Animation type enum with feature for adding custom types.
///To add custom types, take a look at docs.
public struct ANActivityIndicatorAnimationType{

    private var animation : ANActivityIndicatorAnimation.Type
    
    public static let audioEqualizer = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationAudioEqualizer.self)
    public static let ballBeat = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallBeat.self)
    public static let ballClipRotate = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallClipRotate.self)
    public static let ballClipRotateMultiple = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallClipRotateMultiple.self)
    public static let ballClipRotatePulse = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallClipRotatePulse.self)
    public static let ballGridBeat = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallGridBeat.self)
    public static let ballGridPulse = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallGridPulse.self)
    public static let ballPulse = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallPulse.self)
    public static let ballPulseRise = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallPulseRise.self)
    public static let ballPulseSync = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallPulseSync.self)
    public static let ballRotate = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallRotate.self)
    public static let ballRotateChase = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallRotateChase.self)
    public static let ballScale = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallScale.self)
    public static let ballScaleMultiple = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallScaleMultiple.self)
    public static let ballScaleRipple = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallScaleRipple.self)
    public static let ballScaleRippleMultiple = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallScaleRippleMultiple.self)
    public static let ballSpinFadeLoader = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallSpinFadeLoader.self)
    public static let ballTrianglePath = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallTrianglePath.self)
    public static let ballZigZag = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallZigZag.self)
    public static let ballZigZagDeflect = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBallZigZagDeflect.self)
    public static let blank = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationBlank.self)
    public static let cubeTransition = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationCubeTransition.self)
    public static let lineScale = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationLineScale.self)
    public static let lineScaleParty = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationLineScaleParty.self)
    public static let lineScalePulseOut = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationLineScalePulseOut.self)
    public static let lineScalePulseOutRapid = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationLineScalePulseOutRapid.self)
    public static let lineSpinFadeLoader = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationLineSpinFadeLoader.self)
    public static let orbit = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationOrbit.self)
    public static let pacman = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationPacman.self)
    public static let semiCircleSpin = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationSemiCircleSpin.self)
    public static let squareSpin = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationSquareSpin.self)
    public static let triangleSkewSpin = ANActivityIndicatorAnimationType(animation: ANActivityIndicatorAnimationTriangleSkewSpin.self)
    
    public init(animation : ANActivityIndicatorAnimation.Type){
        self.animation = animation
    }
    
    internal func toAnimation() -> ANActivityIndicatorAnimation{
        return animation.init()
    }
}
