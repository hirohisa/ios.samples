//
//  ViewController.swift
//  UIPresentationControllerSample
//
//  Created by Hirohisa Kawasaki on 5/14/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        button.addTarget(self, action: "show", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func show() {
        let viewController = UITableViewController()
        viewController.title = "Presentation"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .Custom
        navigationController.transitioningDelegate = self

        presentViewController(navigationController, animated: true, completion: nil)
    }


    // MARK: UIViewControllerTransitioningDelegate

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: true)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: false)
    }

}

class CustomPresentationController: UIPresentationController {

    var overlay: UIView!

    override func presentationTransitionWillBegin() {

        overlay = UIView(frame: containerView.bounds)
        overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "overlayDidTouch:")]
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0.0
        containerView.insertSubview(overlay, atIndex: 0)

        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({[unowned self] context in
            self.overlay.alpha = 0.5
            }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
        }

    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            overlay.removeFromSuperview()
        }
    }

    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width / 2, height: parentSize.height)
    }

    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView.bounds
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = 0
        presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
        return presentedViewFrame
    }

    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView.bounds
        self.presentedView().frame = frameOfPresentedViewInContainerView()
    }

    override func containerViewDidLayoutSubviews() {
    }

    func overlayDidTouch(sender: AnyObject) {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }

}

class CustomAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    let isPresent: Bool

    init(isPresent: Bool) {
        self.isPresent = isPresent
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            animatePresentTransition(transitionContext)
        } else {
            animateDissmissalTransition(transitionContext)
        }
    }

    func animatePresentTransition(transitionContext: UIViewControllerContextTransitioning) {
        let presentingController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()

        containerView.insertSubview(presentedController.view, belowSubview: presentingController.view)

        let frame = presentedController.view.frame
        presentedController.view.frame.origin.x -= containerView.bounds.size.width
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            presentedController.view.frame = frame
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }

    func animateDissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let containerView = transitionContext.containerView()

        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            presentedController.view.frame.origin.x -= containerView.bounds.size.width
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
}