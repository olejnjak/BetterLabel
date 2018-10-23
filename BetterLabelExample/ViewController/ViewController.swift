//
//  ViewController.swift
//  BetterLabelExample
//
//  Created by Jakub Olejník on 23/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit
import SnapKit
import BetterLabel

final class ViewController: UIViewController {

    private weak var betterLabel: BetterLabel!
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let betterLabel = BetterLabel()
        view.addSubview(betterLabel)
        betterLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        }
        self.betterLabel = betterLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betterLabel.text = "This is BetterLabel!\nYeah, it is better!\n\nSeriously!"
        betterLabel.textColor = .blue
        betterLabel.kern = 2
        betterLabel.lineHeight = 30
        betterLabel.numberOfLines = 0
        betterLabel.textAlignment = .center
        betterLabel.backgroundColor = .yellow
        betterLabel.contentInset = UIEdgeInsets(top: 60, left: 5, bottom: 0, right: 20)
    }
}

