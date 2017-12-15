//
//  MenuView.swift
//  ContainerController
//
//  Created by Ehor Brel on 04.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    
    weak var bottomConstraint: NSLayoutConstraint!
    var circleView: UIView!
    private var backgroundView: UIView!
    private var tapRecognizer: UITapGestureRecognizer!
    private var firstItemButton: UIButton!
    private var secondItemButton: UIButton!
    private weak var container: ContainerViewController!
    private var isFull = false
    
    init(container: ContainerViewController){
        super.init(frame: CGRect(x: 0, y: 10, width: 200, height: 50))
        self.container = container
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        createMenuView()
        createMenuButtons()
        addConstr()
    }
    
    func createMenuButtons(){
        firstItemButton = UIButton(frame:CGRect(x: 0, y: 10, width: 100, height: 100))
        firstItemButton.addTarget(self, action: #selector(firstItemPressed), for: UIControlEvents.touchUpInside)
        firstItemButton.setImage(UIImage(named: "map"), for: .normal)
        firstItemButton.backgroundColor = .white
        firstItemButton.layer.cornerRadius = 50
        secondItemButton = UIButton(frame: CGRect(x: 200, y: 10, width: 100, height: 100))
        secondItemButton.addTarget(self, action: #selector(secondItemPressed), for: UIControlEvents.touchUpInside)
        secondItemButton.setImage(UIImage(named: "poke"), for: .normal)
        secondItemButton.backgroundColor = .white
        secondItemButton.layer.cornerRadius = 50
        firstItemButton.alpha = 0
        secondItemButton.alpha = 0
        self.addSubview(firstItemButton)
        self.addSubview(secondItemButton)
    }
    
    func createMenuView(){
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        self.backgroundView = UIView.init(frame: CGRect(x: UIScreen.main.bounds.width/2 - 25, y: 10, width: 50, height: 50))
        self.backgroundView.layer.cornerRadius = 25
        self.backgroundView.backgroundColor = .black
        self.addSubview(backgroundView)
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        self.circleView = UIView.init(frame: CGRect(x: UIScreen.main.bounds.width/2 - 25, y: 10, width: 50, height: 50))
        self.circleView.addGestureRecognizer(tapRecognizer)
        self.circleView.layer.cornerRadius = 25
        self.circleView.backgroundColor = .black
        self.circleView.isUserInteractionEnabled = true
        drawAdditionalCircles()
        self.addSubview(self.circleView)
        
    }
    
    func showMenuButtons(){
        
        firstItemButton.alpha = 1
        secondItemButton.alpha = 1
    }
    
    func hideMenuButtons(){
        
        firstItemButton.alpha = 0
        secondItemButton.alpha = 0
    }
    
    func addConstr(){
        self.firstItemButton.translatesAutoresizingMaskIntoConstraints = false
        let leadingFBConstraint = NSLayoutConstraint(item: firstItemButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 50)
        let topFBConstraint = NSLayoutConstraint(item: firstItemButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 60)
        let heightFBConstraint = NSLayoutConstraint(item: firstItemButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 100)
        let widthFBConstraint = NSLayoutConstraint(item: firstItemButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 100)
        self.addConstraints([leadingFBConstraint,topFBConstraint,heightFBConstraint,widthFBConstraint])
        
        self.secondItemButton.translatesAutoresizingMaskIntoConstraints = false
        let trailingSBConstraint = NSLayoutConstraint(item: secondItemButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -50)
        let topSBConstraint = NSLayoutConstraint(item: secondItemButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 60)
        let heightSBConstraint = NSLayoutConstraint(item: secondItemButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 100)
        let widthSBConstraint = NSLayoutConstraint(item: secondItemButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 100)
        self.addConstraints([trailingSBConstraint,topSBConstraint,heightSBConstraint,widthSBConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
       
    }
    
    func drawAdditionalCircles(){
        let pathCenter = UIBezierPath(arcCenter: CGPoint(x: 25, y: 25), radius: 5, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        let pathLeft = UIBezierPath(arcCenter: CGPoint(x: 25 - 10, y: 25), radius: 5, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        let pathRight = UIBezierPath(arcCenter: CGPoint(x: 25 + 10, y: 25), radius: 5, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        let combPath = CGMutablePath()
        combPath.addPath(pathCenter.cgPath)
        combPath.addPath(pathLeft.cgPath)
        combPath.addPath(pathRight.cgPath)
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.path = combPath
        layer.fillColor = UIColor.white.cgColor
        self.circleView.layer.addSublayer(layer)
    }
    
    @objc func tapPressed(){
        if !self.isFull{
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.bottomConstraint.constant = CGFloat(-(self.frame.height))
                self.superview?.layoutIfNeeded()
                self.backgroundView.transform = CGAffineTransform(scaleX: 12, y: 12)
                self.showMenuButtons()
            }, completion: { (true) in
                self.isFull = true
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.bottomConstraint.constant = CGFloat(-70)
                self.superview?.layoutIfNeeded()
                self.backgroundView.transform = .identity
                self.hideMenuButtons()
            }, completion: { (true) in
                self.isFull = false
            })
        }
    }
    
    @objc func firstItemPressed(){
       if container.position == .TableController {
            container.switchViewControllers(from: container.arrayOfControllers![1], to: container.arrayOfControllers![0])
            container.position = .MapController
       }
        
    }

    @objc func secondItemPressed(){
        if container.position == .MapController {
            container.switchViewControllers(from: container.arrayOfControllers![0], to: container.arrayOfControllers![1])
            container.position = .TableController
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointInCircle = circleView.convert(point, from: self)
        let pointInFirst = firstItemButton.convert(point, from: self)
        let pointInSecond = secondItemButton.convert(point, from: self)
        if circleView.bounds.contains(pointInCircle)
        {
            return true
        }
        if firstItemButton.bounds.contains(pointInFirst)
        {
            return true
        }
        if secondItemButton.bounds.contains(pointInSecond)
        {
            return true
        }
        return false
    }
}
