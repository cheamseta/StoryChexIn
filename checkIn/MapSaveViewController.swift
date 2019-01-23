//
//  MapSaveViewController.swift
//  checkIn
//
//  Created by seta cheam on 3/4/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class MapSaveViewController: ViewController, CLLocationManagerDelegate, UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var yourImage : UIImage!
    var frameImage : UIImage!
    var currIndex : Int = 0;
    
    var interstitial: GADInterstitial!

    @IBOutlet var nameView: UIView!
    @IBOutlet var cameraButton: UIButton!
    
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var renderView: UIView!
    @IBOutlet var mapImageView: UIImageView!
    @IBOutlet var shareView: UIView!
    
    @IBOutlet var zoomBtn: UIButton!

    var locationManager:CLLocationManager!
    
    var initPoint : CGPoint = CGPoint();
    
    var documentController: UIDocumentInteractionController!
    
    var googleStaticMapUrl : String = "";
    var currentStyleGoogle : String = "";
    
    var selectedImge : UIImageView!
    
    override func viewDidLoad() {
        self.initView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCurrentLocation();
    }
    

    @objc func dismiss(sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil);
    }
    

    
    func getStyle() {
        let serv : Services = Services();
        
        if (self.currIndex > serv.getStyleCount()) {
            self.currIndex = 0;
            self.currentStyleGoogle = serv.getGoogleStyle(index: 0);
        }else{
            self.currentStyleGoogle = serv.getGoogleStyle(index: self.currIndex);
        }
        
    }
    
    func initView () {
        
        self.renderView.layer.cornerRadius = 20;
        
        self.nameView.layer.cornerRadius = 10;
        self.nameView.layer.borderColor = UIColor.darkGray.cgColor;
        self.nameView.layer.borderWidth = 1;
        
        self.zoomBtn.layer.cornerRadius = 20;
        self.zoomBtn.layer.borderColor = UIColor.darkGray.cgColor;
        self.zoomBtn.layer.borderWidth = 1;
        
        self.cameraButton.layer.cornerRadius = 20;
        self.cameraButton.layer.borderColor = UIColor.darkGray.cgColor;
        self.cameraButton.layer.borderWidth = 1;
        self.shareButton.layer.cornerRadius = 20;


        self.mapImageView.downloadedImg(link: self.googleStaticMapUrl);
        
        self.getStyle();
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-7529436346963393/7350744399")
        let request = GADRequest()
        interstitial.load(request)
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray;

        
    }
    
    func shadow(theView : UIView) {
        
        theView.layer.shadowOffset = CGSize(width: 0, height: 5);
        theView.layer.shadowRadius = 8;
        theView.layer.shadowOpacity = 0.3;
        
    }
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let screenWidth : Int = Int(UIScreen.main.bounds.width);
        let screenHeight : Int = Int(UIScreen.main.bounds.height + 200);
        
        self.googleStaticMapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(locValue.latitude),\(locValue.longitude)&zoom=13&size=\(screenWidth)x\(screenHeight)&scale=2&key=AIzaSyDo1lKPO63zmTxQ03_TseIhk6kMYFtlACs\(currentStyleGoogle)"
        
        
        self.initView();
        
        locationManager.stopUpdatingLocation()
        let location : CLLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude);
        self.geoCoder(location: location);
    }
    
    @IBAction func zoomAction(_ sender: Any) {
        
    }
    
    
    func saveImg () -> UIImage {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        let render = UIGraphicsImageRenderer(size: self.renderView.bounds.size);
        let img = render.image { (context) in
            self.renderView.drawHierarchy(in: self.renderView.bounds, afterScreenUpdates: true);
        }
        
        return img;
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    @IBAction func shareToInstagram(_ sender: Any) {
        self.tagger();
        self.yourImage = self.saveImg();
        self.shareToInstagram();
        
    }
    
    func shareToInstagram() {
        let instagramURL = NSURL(string: "instagram://app")
        
        if (UIApplication.shared.canOpenURL(instagramURL! as URL)) {
            
            if let imageData = yourImage!.jpegData(compressionQuality: 100) {
                let filename = getDocumentsDirectory().appendingPathComponent("instagram.igo")
                
                try? imageData.write(to: filename)
                
                let captionString = "caption"
                
                self.documentController = UIDocumentInteractionController(url: filename as URL)
                
                self.documentController.delegate = self
                
                self.documentController.uti = "com.instagram.exlusivegram"
                
                self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption" as NSCopying)
                self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
                
                
            }
            
        } else {
            print(" Instagram isn't installed ")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func geoCoder(location : CLLocation) {
        let geo : CLGeocoder =  CLGeocoder();
        geo.reverseGeocodeLocation(location) {(placemark, err) in
            if (err == nil) {
                let place : CLPlacemark = placemark![0];
                
                self.countryLabel.text = place.country!;
                
                let dict : Dictionary = place.addressDictionary!;
                self.cityLabel.text = dict["State"] as? String;
                
            }else{
                
            }
        };
    }
    
    func tagger () {
        let lable : UILabel = UILabel(frame: CGRect(x: 0, y: self.renderView.frame.size.height - 30, width: self.renderView.frame.size.width - 5, height: 15));
        
        lable.text = "ChexIn App";
        lable.textAlignment = NSTextAlignment.right;
        lable.textColor = UIColor.darkGray;
        lable.font = UIFont.systemFont(ofSize: 10);
        self.renderView.addSubview(lable);
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        let img = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage;

        dismiss(animated: true,completion: {
            self.addRoundImageToView(img: img);
        })
    }
    
    func addRoundImageToView(img : UIImage) {
    
        let floatImageView : RoundShadowView = RoundShadowView(frame: CGRect(x: self.renderView.center.x, y: self.renderView.center.y, width: 100, height: 100));
        floatImageView.image = img;
        floatImageView.isUserInteractionEnabled = true;
        floatImageView.layer.cornerRadius = 50;
        
        self.selectedImge = floatImageView;
        
        let panGuesture : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPanGuest(sender:)));
        floatImageView.addGestureRecognizer(panGuesture);
        
        let pinchGuesture : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(onPinchScal(sender:)));
        self.renderView.addGestureRecognizer(pinchGuesture);

        self.renderView .addSubview(floatImageView)
        
    }
    
    @objc func onPinchScal(sender : UIPinchGestureRecognizer) {
        
        guard sender.view != nil else { return }
        
        if sender.state == .began || sender.state == .changed {
            self.selectedImge.transform = (self.selectedImge?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    
        
    }
    
    @objc func onPanGuest(sender : UIPanGestureRecognizer) {
        
        
        guard sender.view != nil else { return }
        
        let movingView = sender.view!;
        let translate = sender.translation(in: self.renderView)
        
        if sender.state == .began {
            self.initPoint = movingView.center;
        }
        
        if sender.state != .cancelled {
            let newPoint = CGPoint(x: self.initPoint.x + translate.x, y: self.initPoint.y + translate.y);
            movingView.center = newPoint;
        }else{
            movingView.center = self.initPoint;
        }
        
    }
    
    
    @IBAction func cameraAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imgPicker = UIImagePickerController();
            imgPicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imgPicker.sourceType = .camera;
            imgPicker.allowsEditing = true;
            self.present(imgPicker, animated: true, completion: nil);
        }
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
    }
    
}


//    @IBAction func statusAlertView () {
//
//
//        let alertController = UIAlertController(title: "Status", message: "Please fill out your status", preferredStyle: .alert)
//
//        alertController.addTextField(configurationHandler: { (textField) in
//            textField.placeholder = "Your status ..."
//        })
//
//        let action1 = UIAlertAction(title: "DONE", style: .default) { (action:UIAlertAction) in
//            let firstTextField = alertController.textFields![0] as UITextField
//            self.statusLabel.text = firstTextField.text;
//        }
//
//        alertController.addAction(action1)
//        self.present(alertController, animated: true, completion: nil)
//
//    }
//
//    @IBAction func mapStyleListAction(_ sender: Any) {
//        let listController : StyleListViewController = StyleListViewController()
//        listController.delegate = self;
//
//        let nav : UINavigationController = UINavigationController(rootViewController: listController)
//
//        self .present(nav, animated: true, completion: nil);
//    }
//
//    func didSelectTable(index: NSInteger) {
//        self.currIndex = index;
//        self.getStyle();
//        self.getCurrentLocation();
//    }Ï
