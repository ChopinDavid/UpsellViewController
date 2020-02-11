//
//  UpsellAction.swift
//  UpsellViewController
//
//  Created by David G Chopin on 2/11/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

@objc public enum UpsellActionStyle: Int {
    case `default`
    case cancel
}

public class UpsellAction: UIButton {
    
    fileprivate var action: (() -> Void)?
    
    var actionStyle: UpsellActionStyle
    
    var separator = UIView()
    
    init(){
        self.actionStyle = .cancel
        super.init(frame: CGRect.zero)
    }
    
    @objc public convenience init(title: String?, style: UpsellActionStyle, action: (() -> Void)? = nil) {
        self.init()
        
        self.action = action
        self.addTarget(self, action: #selector(UpsellAction.tapped(_:)), for: .touchUpInside)
        
        self.setTitle(title, for: UIControl.State())
        
        self.actionStyle = style
        style == .default ? (self.setTitleColor(UIColor(red: 81/255, green: 189/255, blue: 209/255, alpha: 1), for: UIControl.State())) : (self.setTitleColor(UIColor.gray, for: UIControl.State()))
        
        self.addSeparator()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(_ sender: UpsellAction) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.action?()
        }
    }
    
    @objc fileprivate func addSeparator(){
        separator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.addSubview(separator)
        
        // Autolayout separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 8).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -8).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}

