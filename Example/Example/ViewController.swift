//
//  ViewController.swift
//  Example
//
//  Created by Arda Oğul Üçpınar on 7.01.2018.
//  Copyright © 2018 Avorna Yazılım Ltd. Şti. All rights reserved.
//

import UIKit
import ANActivityIndicator

class ViewController: UICollectionViewController {
    
    //all animations (32) and custom animation
    let animationList : [ANActivityIndicatorAnimationType] = [
        ANActivityIndicatorAnimationType.audioEqualizer,
        ANActivityIndicatorAnimationType.ballBeat,
        ANActivityIndicatorAnimationType.ballClipRotate,
        ANActivityIndicatorAnimationType.ballClipRotateMultiple,
        ANActivityIndicatorAnimationType.ballClipRotatePulse,
        ANActivityIndicatorAnimationType.ballGridBeat,
        ANActivityIndicatorAnimationType.ballGridPulse,
        ANActivityIndicatorAnimationType.ballPulse,
        ANActivityIndicatorAnimationType.ballPulseRise,
        ANActivityIndicatorAnimationType.ballPulseSync,
        ANActivityIndicatorAnimationType.ballRotate,
        ANActivityIndicatorAnimationType.ballRotateChase,
        ANActivityIndicatorAnimationType.ballScale,
        ANActivityIndicatorAnimationType.ballScaleMultiple,
        ANActivityIndicatorAnimationType.ballScaleRipple,
        ANActivityIndicatorAnimationType.ballScaleRippleMultiple,
        ANActivityIndicatorAnimationType.ballSpinFadeLoader,
        ANActivityIndicatorAnimationType.ballTrianglePath,
        ANActivityIndicatorAnimationType.ballZigZag,
        ANActivityIndicatorAnimationType.ballZigZagDeflect,
        ANActivityIndicatorAnimationType.blank,
        ANActivityIndicatorAnimationType.cubeTransition,
        ANActivityIndicatorAnimationType.lineScale,
        ANActivityIndicatorAnimationType.lineScaleParty,
        ANActivityIndicatorAnimationType.lineScalePulseOut,
        ANActivityIndicatorAnimationType.lineScalePulseOutRapid,
        ANActivityIndicatorAnimationType.lineSpinFadeLoader,
        ANActivityIndicatorAnimationType.orbit,
        ANActivityIndicatorAnimationType.pacman,
        ANActivityIndicatorAnimationType.semiCircleSpin,
        ANActivityIndicatorAnimationType.squareSpin,
        ANActivityIndicatorAnimationType.triangleSkewSpin,
        ANActivityIndicatorAnimationType.customAnimation
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animationList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //indicator initialized via SB.
        //initializaton from scratch:
        //        let indicator = ANActivityIndicatorView.init(
        //            frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: (collectionView.frame.size.width - 30) / 4, height: collectionView.frame.size.width/8)),
        //            animationType: animationList[indexPath.row],
        //            color: UIColor.white,
        //            padding: 0)
        
        let indicatorView = cell.viewWithTag(1) as! ANActivityIndicatorView
        
        //prepare cell's indicatorView for reuse
        if indicatorView.isAnimating{
            indicatorView.stopAnimating()
        }
        
        //set animation type
        indicatorView.animationType = animationList[indexPath.row]
        
        //need to layout cell to adapt its layer to cell size. or you can layout indicatorView only.
        cell.layoutIfNeeded()
        
        //start animating
        indicatorView.startAnimating()
        
        
        //counter label from example project
        let numberLabel = cell.viewWithTag(2) as! UILabel
        if indexPath.row == collectionView.numberOfItems(inSection: 0) - 1 {
            numberLabel.text = "Custom\nAnimation"
        }
        else{
            numberLabel.text = "\(indexPath.row + 1)"
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //show indicator. this is special for controllers.
        self.showIndicator(
            self.view.frame.size,
            message: "Loading...", //FIXME: message not showing
            messageFont: nil,
            animationType: animationList[indexPath.row],
            color: UIColor.white,
            padding: self.view.frame.size.width / 5 * 4,
            displayTimeThreshold: 2, //FIXME: not workimg
            minimumDisplayTime: 5)//FIXME: not working
        
        //if you gonna call from AppDelegate or from a clas which is not a controller subclass; you can use shared presenter.
//        ANActivityIndicatorPresenter.shared.showIndicator(
//            self.view.frame.size,
//            message: "Loading...",
//            messageFont: nil,
//            animationType: animationList[indexPath.row],
//            color: UIColor.white,
//            padding: self.view.frame.size.width / 5 * 4,
//            displayTimeThreshold: 2,
//            minimumDisplayTime: 5)
        
        
        //helper for example project to automaticaaly hide indicator.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.hideIndicator()//or ANActivityIndicatorPresenter.shared.hideIndicator()
        }
    }

}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row <= collectionView.numberOfItems(inSection: 0) - 2{
            return CGSize.init(width: (collectionView.frame.size.width - 30) / 4, height: collectionView.frame.size.width/8)
        }
        else{
            return CGSize.init(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/8)
        }
    }
}

