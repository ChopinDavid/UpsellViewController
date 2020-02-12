//
//  UpsellViewController.swift
//  UpsellViewController
//
//  Created by David G Chopin on 2/11/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

public class UpsellViewController: UIViewController {
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollContentView: UIView!
    @IBOutlet var actionStackView: UIStackView!
    @IBOutlet var scrollContentViewHeight: NSLayoutConstraint!
    @IBOutlet var scrollContentViewWidth: NSLayoutConstraint!
    @IBOutlet var actionStackViewHeight: NSLayoutConstraint!
    
    var stackViewHeight : CGFloat = UIScreen.main.bounds.height < 568.0 ? 40 : 62 //if iphone 4 the stack_view_height is 40, else 62
    
    var promoView: UIView!
    
    var timer: Timer!
    var pageIndex: Int = 0
    
    var autoScrollDirection: Direction = .right
    var numberOfPages: Int!
    
    public var pageIndicatorTintColor: UIColor = .lightGray
    public var currentPageIndicatorTintColor: UIColor = UIColor(red: 81/255, green: 189/255, blue: 209/255, alpha: 1)
    
    public var isAutoScrollEnabled: Bool = true
    public var autoScrollBuffer: TimeInterval = 4.0
    public var autoScrollSpeed: TimeInterval = 0.75
    
    @objc public convenience init(title: String, subtitle: String, promoView: UIView, numberOfPages: Int) {
        self.init()
        guard let nib = loadNibUpsellController(), let unwrappedView = nib[0] as? UIView else { return }
        self.view = unwrappedView
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.promoView = promoView
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.scrollContentView = scrollContentView
        self.numberOfPages = numberOfPages
        self.pageControl.numberOfPages = numberOfPages
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.alpha = 0
        self.scrollView.delegate = self
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutScrollContentView()
        
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25) {
            self.contentView.alpha = 1
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
        
        if isAutoScrollEnabled {
            timer = Timer.scheduledTimer(timeInterval: autoScrollBuffer, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    func layoutScrollContentView() {
        scrollContentViewWidth.constant = contentView.bounds.width * CGFloat(numberOfPages)
        scrollContentView.addSubview(promoView)
        promoView.translatesAutoresizingMaskIntoConstraints = false

        promoView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor).isActive = true
        promoView.topAnchor.constraint(equalTo: scrollContentView.topAnchor).isActive = true
        promoView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor).isActive = true
        promoView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor).isActive = true
    }
    
    @objc func autoScroll() {
        UIView.animate(withDuration: autoScrollSpeed, animations: {
            if self.autoScrollDirection == .right {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + self.scrollView.bounds.width, y: self.scrollView.contentOffset.y), animated: false)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x - self.scrollView.bounds.width, y: self.scrollView.contentOffset.y), animated: false)
            }
        }, completion: nil)
    }
    
    @objc fileprivate func loadNibUpsellController() -> [AnyObject]?{
        let podBundle = Bundle(for: self.classForCoder)
        
        if let bundleURL = podBundle.url(forResource: "UpsellViewController", withExtension: "bundle"){
            
            if let bundle = Bundle(url: bundleURL) {
                return bundle.loadNibNamed("UpsellViewController", owner: self, options: nil) as [AnyObject]?
            }
            else {
                assertionFailure("Could not load the bundle")
            }
            
        }
        else if let nib = podBundle.loadNibNamed("UpsellViewController", owner: self, options: nil) as [AnyObject]?{
            return nib
        }
        else{
            assertionFailure("Could not create a path to the bundle")
        }
        return nil
    }
    
    @objc open func addAction(_ upsellAction: UpsellAction){
        actionStackView.addArrangedSubview(upsellAction)
        
        if actionStackView.arrangedSubviews.count > 2 {
            actionStackViewHeight.constant = stackViewHeight * CGFloat(actionStackView.arrangedSubviews.count)
            actionStackView.axis = .vertical
        } else {
            actionStackViewHeight.constant = stackViewHeight
            actionStackView.axis = .horizontal
        }
        
        upsellAction.addTarget(self, action: #selector(UpsellViewController.dismiss(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func dismiss(_ sender: UpsellAction){
        self.dismiss(animated: true, completion: nil)
    }
}

extension UpsellViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = Int(floor(Double(scrollView.contentOffset.x/scrollContentView.frame.width) * Double(numberOfPages)))
        print(offset)
        pageControl.currentPage = offset
        pageIndex = offset
        
        if offset == 0 {
            autoScrollDirection = .right
        } else if offset == numberOfPages - 1 {
            autoScrollDirection = .left
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if timer != nil {
            timer.invalidate()
        }
    }
}

enum Direction {
    case left, right
}

