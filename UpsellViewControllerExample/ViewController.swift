//
//  ViewController.swift
//  UpsellViewControllerExample
//
//  Created by David G Chopin on 2/11/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit
import SafariServices
import UpsellViewController

class ViewController: UIViewController {
    @IBOutlet var presentUpsellVC1Button: UIButton!
    @IBOutlet var presentUpsellVC2Button: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presentUpsellVC1Button.layer.cornerRadius = presentUpsellVC1Button.frame.height / 2
        presentUpsellVC2Button.layer.cornerRadius = presentUpsellVC2Button.frame.height / 2
    }
    
    @IBAction func presentUpsellVC1ButtonPressed(_ sender: Any) {
        //Get all views in the xib
        let allViewsInXibArray = Bundle.main.loadNibNamed("PromoView1", owner: self, options: nil)
        
        //If you only have one view in the xib and you set it's class to MyView class
        let promoView = allViewsInXibArray!.first as! UIView
        let upsellVC = UpsellViewController(title: "Refer a Friend and You'll Both Get Bandmate Plus, for Life!", subtitle: "With Plus, you can...", promoView: promoView, numberOfPages: 5)
        
        //upsellVC.autoScrollBuffer is the amount of time, in seconds, the UpsellViewController will wait between autoscrolling the content view. Lower = faster
        upsellVC.autoScrollBuffer = 5
        
        //upsellVC.autoScrollSpeed is the amount of time, in seconds, the UpsellViewController takes to animate the autoscrolling of the content view. Lower = faster
        upsellVC.autoScrollSpeed = 0.3
        
        let referAFriend = UpsellAction(title: "Refer a Friend", style: .default) {
            let activityViewController = UIActivityViewController(activityItems: ["Hey! I'm inviting you to download Bandmate, a music networking app that can help your projects get seen!\n\nIf you accept this invitation and download the app, both you and I will receive a lifetime subscription to Bandmate Plus! Bandmate Plus lets users promote their local gigs, preview compatibility with other users, change their location, and preview likes!\n\nHere's the link to install: https://www.bandmate.us"], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = []

            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        upsellVC.addAction(referAFriend)
        let learnMore = UpsellAction(title: "Learn More", style: .default) {
            let url = URL(string: "https://www.bandmate.us/plus.html")!
            let controller = SFSafariViewController(url: url)
            self.present(controller, animated: true, completion: nil)
        }
        upsellVC.addAction(learnMore)
        let cancel = UpsellAction(title: "Cancel", style: .cancel)
        upsellVC.addAction(cancel)
        present(upsellVC, animated: false, completion: nil)
    }
    
    @IBAction func presentUpsellVC2ButtonPressed(_ sender: Any) {
        //Get all views in the xib
        let allViewsInXibArray = Bundle.main.loadNibNamed("PromoView2", owner: self, options: nil)
        
        //If you only have one view in the xib and you set it's class to MyView class
        let promoView = allViewsInXibArray!.first as! UIView
        let upsellVC = UpsellViewController(title: "Refer a Friend and You'll Both Get Bandmate Plus, for Life!", subtitle: "With Plus, you can...", promoView: promoView, numberOfPages: 2)
        
        //upsellVC.isAutoScrollEnabled is a boolean dictating whether or not the UpsellViewController's content view autoscrolls.
        upsellVC.isAutoScrollEnabled = false
        
        //Change the page control tint colors
        upsellVC.pageIndicatorTintColor = .systemIndigo
        upsellVC.currentPageIndicatorTintColor = .green
        
        let cancel = UpsellAction(title: "Cancel", style: .cancel)
        upsellVC.addAction(cancel)
        let referAFriend = UpsellAction(title: "Refer a Friend", style: .default) {
            let activityViewController = UIActivityViewController(activityItems: ["Hey! I'm inviting you to download Bandmate, a music networking app that can help your projects get seen!\n\nIf you accept this invitation and download the app, both you and I will receive a lifetime subscription to Bandmate Plus! Bandmate Plus lets users promote their local gigs, preview compatibility with other users, change their location, and preview likes!\n\nHere's the link to install: https://www.bandmate.us"], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = []

            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        upsellVC.addAction(referAFriend)
        present(upsellVC, animated: false, completion: nil)
    }
}

