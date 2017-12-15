//
//  ImageAnnotationView.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 01.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import Foundation
import MapKit
import Foundation

class ImageAnnotationView: MKAnnotationView {
    var imageView: UIImageView!
    var progressBar: UIActivityIndicatorView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.annotation = annotation
        self.progressBar = UIActivityIndicatorView(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.imageView.backgroundColor = .black
        self.addSubview(self.imageView)
        self.addSubview(progressBar)
        progressBar.startAnimating()
        self.imageView.layer.cornerRadius = 5.0
        self.imageView.layer.masksToBounds = true
        
        if let image = (annotation as!ImageAnnotation).image{
            setImage(image: image)
        }
    }
    
    func setImage(image: UIImage){
        DispatchQueue.main.async {
            self.progressBar.stopAnimating()
            self.imageView.backgroundColor = UIColor.clear
            self.imageView.image = image
        }
    }
    
//    func loadImage(imageString: String){
//        let stringUrl =  "\(Constants.Heroku.baseAPIURL)/\(Constants.Heroku.smallPictFolder)\(imageString)"
//        guard let url = URL(string: stringUrl) else { return }
//        URLSession.shared.dataTask(with: url){ (data,response,error) in
//            guard let data = data else {
//                return
//            }
//            DispatchQueue.main.async {
//                self.progressBar.stopAnimating()
//                self.imageView.backgroundColor = UIColor.clear
//                (self.annotation as! ImageAnnotation).image = UIImage(data: data, scale: UIScreen.main.scale)
//                self.imageView.image = UIImage(data: data, scale: UIScreen.main.scale)
//            }
//            }.resume()
//    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
