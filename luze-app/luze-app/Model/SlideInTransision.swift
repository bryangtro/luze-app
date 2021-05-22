//
//  SlideInTransision.swift
//  luze-app
//
//  Created by Geraldo Gosal on 8/5/21.
//

import UIKit

class SlideInTransision: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewContoller = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let contrainerView = transitionContext.containerView
        
        let finalWidth = toViewContoller.view.bounds.width * 0.8
        let finalHeight = toViewContoller.view.bounds.height
        
        if isPresenting {
            
            //add dimming view
            contrainerView.addSubview(dimmingView)
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            dimmingView.frame = contrainerView.bounds
            //add MenuViewController to container
            contrainerView.addSubview(toViewContoller.view)
            
            //Init frame off the screen
            toViewContoller.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on Sscreen
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewContoller.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //Animate back off screen
        let identitiy = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {self.isPresenting ? transform() : identitiy()}) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
    

}
