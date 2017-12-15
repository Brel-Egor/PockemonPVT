//
//  ContainerViewController.swift
//  ContainerController
//
//  Created by Ehor Brel on 03.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit

enum Position: Int{
    case MapController
    case TableController
}

class ContainerViewController: UIViewController {

    private var menuViewOffset = CGFloat(-70)
    var position: Position = Position.MapController
    private weak var rootViewController: UIViewController?
    var arrayOfControllers: [UIViewController]?
    private var menuView: MenuView!
    private var bottomMVConstraint: NSLayoutConstraint!
    

    init(arrayOfControllers: [UIViewController]){
        super.init(nibName: nil, bundle: nil)
        menuView = MenuView.init(container: self)
        self.arrayOfControllers = arrayOfControllers
        if let array = self.arrayOfControllers{
            self.rootViewController = array[0]
            self.showInitial(initVC: self.rootViewController!)
        }
        addConstraints()
    }
    
    func setupMenuView(){
        self.view.addSubview(self.menuView)
    }
    
    func addConstraints(){
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        let leadingMVConstraint = NSLayoutConstraint(item: menuView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let trailingMVConstraint = NSLayoutConstraint(item: menuView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let heightMVConstraint = NSLayoutConstraint(item: menuView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.height, multiplier: 0.4, constant: 0)
        bottomMVConstraint = NSLayoutConstraint(item: menuView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: menuViewOffset)
    self.view.addConstraints([leadingMVConstraint,trailingMVConstraint,heightMVConstraint,bottomMVConstraint])
        self.menuView.bottomConstraint = bottomMVConstraint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showInitial(initVC: UIViewController){
        self.rootViewController = initVC
        self.addChildViewController(initVC)
        initVC.view.frame = self.view.bounds
        self.view.addSubview(initVC.view)
        initVC.didMove(toParentViewController: self)
        self.setupMenuView()
        position = .MapController
    }
    
    private func removeViewController(childView: UIViewController){
        childView.willMove(toParentViewController: nil)
        childView.view.removeFromSuperview()
        childView.removeFromParentViewController()
    }
    
    func frameForCircle(center: CGPoint, size: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, size.width - start.x)
        let lengthY = fmax(start.y, size.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    func switchViewControllers(from presentVC: UIViewController,to endVC: UIViewController){
        presentVC.willMove(toParentViewController: nil)
        self.addChildViewController(endVC)
        endVC.view.frame = self.view.bounds
        let originalCenter = endVC.view.center
        let originalSize = endVC.view.frame.size
        let circle = UIView(frame: frameForCircle(center: originalCenter, size: originalSize, start: originalCenter))
        circle.layer.cornerRadius = circle.frame.size.height / 2
        circle.center = originalCenter
        circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        circle.backgroundColor = endVC.view.backgroundColor
        self.view.addSubview(circle)
        
        endVC.view.center = originalCenter
        endVC.view.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        self.view.addSubview(endVC.view)
        self.setupMenuView()
        UIView.animate(withDuration: 1, animations: {
            circle.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            endVC.view.transform = CGAffineTransform.init(scaleX:1, y: 1)
            endVC.view.center = originalCenter
        }, completion: { (true) in
            circle.removeFromSuperview()
        })
        
        presentVC.view.removeFromSuperview()
        presentVC.removeFromParentViewController()
        endVC.didMove(toParentViewController: self)
        self.rootViewController = endVC
    }
    

}
