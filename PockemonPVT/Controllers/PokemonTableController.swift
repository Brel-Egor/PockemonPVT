//
//  PokemonTable.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 08.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import UIKit

class PokemonTableController: UIViewController {

    var table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var tableDelegate = PokemonTableDelegate.sharedInstance
    
    init(){
        super.init(nibName: nil, bundle: nil)
        table.register(PokemonCell.self, forCellReuseIdentifier: "cell")
        table.delegate = tableDelegate
        table.dataSource = tableDelegate
        tableDelegate.table = table
        self.view.backgroundColor = .white
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func createView(){
        self.view.addSubview(table)
        addConstraint()
    }
    

    func addConstraint(){
        table.translatesAutoresizingMaskIntoConstraints = false
        let leadingTVConstraint = NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let trailingTVConstraint = NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let topTVConstraint = NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        let bottomTVConstraint = NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([leadingTVConstraint,trailingTVConstraint,bottomTVConstraint,topTVConstraint])
    }

}
