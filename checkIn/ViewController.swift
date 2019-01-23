//
//  ViewController.swift
//  checkIn
//
//  Created by seta cheam on 3/4/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {

   
    @IBOutlet var holderViewLogo: UIView!
    @IBOutlet var hereButton: UIButton!
    @IBOutlet var adView: GADBannerView!
    @IBOutlet var menuView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChexIn";
     
        self.setupNaviation();
        
        self.adView.delegate = self
        self.adView.adUnitID = "ca-app-pub-7529436346963393/9382011368"
        self.adView.rootViewController = self
        self.adView.load(GADRequest())
        
        let progressView = BLEProgressView()
        progressView.initProfileImg(profileImg: UIImage(named: "Pin")!);
        progressView.frame = self.holderViewLogo.bounds
        self.holderViewLogo.addSubview(progressView)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             self.onWalkthrough()
        }
    
    }
    
    func setupNaviation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"More"), style: UIBarButtonItem.Style.plain,
                                                                 target:self,
                                                                 action:#selector(listMenu(sender:)));
    }

    func onWalkthrough() {
        
        if !UserDefaults.standard.bool(forKey: "walkthrough") {
            let walk : WalkthroughViewController = WalkthroughViewController();
            self .present(walk, animated: true, completion: nil);
            UserDefaults.standard.set(true, forKey: "walkthrough");
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func listMenu(sender:Any) {
        self.menuView.frame = self.view.frame;
        self.view.addSubview(self.menuView);
        self.menuView.alpha = 0;
        
        UIView.animate(withDuration: 0.5) {
            self.menuView.alpha = 1;
        }
        
    }
 
    @IBAction func AboutUs(_ sender: Any) {
        guard let url = URL(string: "https://noway-web.herokuapp.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func dismissMenu(_ sender: Any) {
    
        UIView.animate(withDuration: 0.5, animations: {
            self.menuView.alpha = 0;
        }) { (true) in
                self.menuView.removeFromSuperview()
        }
    }
    

    @IBAction func showMapSaveController(_ sender: UIButton) {

        let styleListViewController : StyleListViewController = StyleListViewController();
        self.navigationController?.pushViewController(styleListViewController, animated: true);
    }
    

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}

