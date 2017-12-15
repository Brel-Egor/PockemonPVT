//
//  PokemonCell.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 09.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//
import UIKit

class PokemonCell: UITableViewCell {

    let imageField = UIImageView()
    let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.imageField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageField)
        
        let heightIFConstraint = NSLayoutConstraint(item: imageField ,attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 100)
        
        let widthIFConstraint = NSLayoutConstraint(item: imageField ,attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 100)
        
        let topConstraint = NSLayoutConstraint(item: self ,attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
        
        addConstraint(topConstraint)
        addConstraints([heightIFConstraint, widthIFConstraint])
    }
    
    func setData(entity:PokemonCD){
        self.imageField.image = UIImage.init(data:entity.image! as Data)
    }
    
    override func prepareForReuse() {
        self.imageField.image = nil
    }
}
