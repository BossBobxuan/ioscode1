//
//  MapWeatherViewController.swift
//  weather
//
//  Created by bossxuan on 16/11/2.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapWeatherViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,updateuserdefaultdelegate {
    @IBOutlet weak var mapView: MKMapView!
        {didSet{mapView.delegate = self}}
    var dataModels : [locationsub] = [locationsub]()
    let manager = CLLocationManager()
    let defalut = NSUserDefaults.standardUserDefaults()
    // MARK: - Action
    
    @IBAction func longPress(sender: UILongPressGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Began
        {
            let coordinate = mapView.convertPoint(sender.locationInView(mapView), toCoordinateFromView: mapView)
            print(coordinate)
            let dataModel = locationsub()
            dataModel.getdata(coordinate.latitude, longitude: coordinate.longitude)
            dataModels.append(dataModel)
            mapView.addAnnotation(dataModels[dataModels.count - 1])
        }
    }
    // MARK: - func
    func updateAnnotation()
    {
        mapView.addAnnotation(dataModels[dataModels.count - 1])
        mapView.showAnnotations(dataModels, animated: true)
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "111")
        let button = UIButton(type: .DetailDisclosure)
        view.canShowCallout = true
        view.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 59, height: 59))
        view.rightCalloutAccessoryView = button
        return view
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        if let annotation = view.annotation as? locationsub
        {
            if let imageView = view.leftCalloutAccessoryView as? UIImageView
            {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
                {
                    let imagedata = NSData(contentsOfURL: annotation.iconurl)
                    if imagedata != nil
                    {
                        dispatch_async(dispatch_get_main_queue(), {
                            if let image = UIImage(data: imagedata!)
                            {
                                imageView.image = image
                            }
                        })
                    }
                }
            }
        }
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as! UIButton).buttonType == .DetailDisclosure
        {
            performSegueWithIdentifier("showdetail", sender: view)
        }
    }
    
    
    
    
    
    
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[locations.count - 1]
        if (location.horizontalAccuracy > 0)
        {
            let dataModel = locationsub()
            dataModel.getdata(location.coordinate.latitude, longitude: location.coordinate.longitude)
            dataModels.append(dataModel)
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            updateAnnotation()
            manager.stopUpdatingLocation()
            
        }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    
    
    
    
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        if let cityname  = defalut.objectForKey("cityname") as? NSArray
        {
            print("YES")
            for index in cityname
            {
                print("YES2")
                let string = index as! String
                let model = locationsub()
                self.getdata(string, model: model)
                dataModels.append(model)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        print("appear")
    }
    func getdata(city : String, model : locationsub)
    {
        //        let url = constants.url + "?" + "q=\(city)" + "&appid=\(constants.id)"
        //        let request = NSURLRequest(URL: NSURL(string: url)!)
        //        self.latitude = 11.2
        //        self.longitude = 20.5
        //        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
        //            let dic : NSDictionary!
        //
        //            try! dic = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        //
        //            self.updateVar(dic, id: 1)
        //        }
        
        let manager = AFHTTPSessionManager()
        model.city = city
        manager.GET(constants.url, parameters: ["q":city,"appid": constants.id], success: { (DataTask, response) in
            model.updateVar(response as! NSDictionary, id: 1)//if city id = 1
            self.mapView.addAnnotation(model)
            
            
        }) { (DataTask, error) in
            print(error)
            //issucceed = false
            model.city = "Sorry,can`t find the weather"
            model.tmp = ""
        }
        
        
    }
    func updateuserdefault() {
        mapView.removeAnnotations(dataModels)
        if let cityname  = defalut.objectForKey("cityname") as? NSArray
        {
            print("YES")
            for index in cityname
            {
                print("YES2")
                let string = index as! String
                let model = locationsub()
                self.getdata(string, model: model)
                dataModels.append(model)
            }
        }
    }
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if  segue.identifier! == "showdetail"
        {
            if let nextmvc = segue.destinationViewController as? DetailViewController
            {
                nextmvc.model = (sender as! MKAnnotationView).annotation as! locationsub
            }
        }else
        {
            if let nextmvc = segue.destinationViewController as? CityTableViewController
            {
                print("ok")
            
                nextmvc.delegate = self
            
            }
        }
    }
    

}
