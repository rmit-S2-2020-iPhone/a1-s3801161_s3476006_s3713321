//
//  SlideTransit.swift
//  CountDone
//
//  Created by Fanwei Wang on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class SlideTransit: NSObject,UIViewControllerAnimatedTransitioning {
    var isPresneting = false
    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else{return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width*0.8
        let finalHeight = toViewController.view.bounds.height
    
        if isPresneting{
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            containerView.addSubview(toViewController.view)
       
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations:{
            self.isPresneting ? transform() : identity()
        }){ (_) in
            transitionContext.completeTransition(!isCancelled)
            
        }
    }
    
    
    


    
}
