//
//  PopoverViewController.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 08.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit

class PopoverView: UIView{
    weak var superView: UIView?
    var viewForData = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var title = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var effectView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    init(superView:UIView){
        super.init(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height))
        self.superView = superView
        viewForData.backgroundColor = .white
        self.addSubview(effectView)
        self.createDataView()
        self.addSubview(viewForData)
        self.createConstraints()
    }
    
    func createDataView(){
        viewForData.backgroundColor = .white
        viewForData.addSubview(title)
        viewForData.addSubview(imageView)
        viewForData.addSubview(button)
        button.addTarget(self, action: #selector(dismiss), for: UIControlEvents.touchUpInside)
        button.setTitle("ok", for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    func animateIn(){
        UIView.animate(withDuration: 0.5) {
            self.effectView.effect = UIBlurEffect(style: .light)
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.5) {
            self.effectView.effect = UIBlurEffect()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createConstraints() {
        self.effectView.translatesAutoresizingMaskIntoConstraints = false
        let leadingEVConstraint = NSLayoutConstraint(item: self.effectView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let topEVConstraint = NSLayoutConstraint(item: self.effectView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        let trailingEVConstraint = NSLayoutConstraint(item: self.effectView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let bottomEVConstraint = NSLayoutConstraint(item: self.effectView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        self.addConstraints([leadingEVConstraint,topEVConstraint,trailingEVConstraint,bottomEVConstraint])
        
        self.viewForData.translatesAutoresizingMaskIntoConstraints = false
        
        let centerxVDConstraint = NSLayoutConstraint(item: self.viewForData, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        let centeryVDConstraint = NSLayoutConstraint(item: self.viewForData, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
        let widthVDConstraint = NSLayoutConstraint(item: self.viewForData, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 150)
        let heightVDConstraint = NSLayoutConstraint(item: self.viewForData, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 200)
        
        self.addConstraints([centerxVDConstraint,centeryVDConstraint,widthVDConstraint,heightVDConstraint])
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingTConstraint = NSLayoutConstraint(item: self.title, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 25)
        let leadingTConstraint = NSLayoutConstraint(item: self.title, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 50)
        let topTConstraint = NSLayoutConstraint(item: self.title, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
        let heightTConstraint = NSLayoutConstraint(item: self.title, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 20)
        
        self.addConstraints([trailingTConstraint,leadingTConstraint,topTConstraint,heightTConstraint])
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingIVConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let leadingIVConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let topIVConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.title, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        let heightIVConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 100)
        
        self.addConstraints([trailingIVConstraint,leadingIVConstraint,topIVConstraint,heightIVConstraint])
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingBConstraint = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let leadingBConstraint = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.viewForData, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let topBConstraint = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.imageView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 20)
        let heightBConstraint = NSLayoutConstraint(item: self.button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 20)
        
        self.addConstraints([trailingBConstraint,leadingBConstraint,topBConstraint,heightBConstraint])
        
    }
    
    func setData(annotation: ImageAnnotation){
        title.text = annotation.title
        imageView.image = annotation.image
    }

    @objc func dismiss(){
        self.animateOut()
        self.removeFromSuperview()
    }
}
