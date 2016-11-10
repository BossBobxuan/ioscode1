//
//  locationsub.swift
//  weather
//
//  Created by bossxuan on 16/11/1.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import MapKit
struct constants {
     static let id : String = "fe5853a4052a04180f125eef56eddb87"
     static let url : String = "http://api.openweathermap.org/data/2.5/weather"
     static let iconurl : String = "http://openweathermap.org/img/w/"
}
class locationsub : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
        {
        return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    var isruning : Bool = true
    var city = ""
    var tmp = ""
    var latitude : CLLocationDegrees?
    var longitude : CLLocationDegrees?
    var iconparams : String = ""
    var iconurl : NSURL{
        return NSURL(string: iconparams)!
    }
    var title: String?{
                return city
            }
    var subtitle: String?{
                return tmp
            }
    init(city : String)
    {
        super.init()
        self.city = city
        self.getdata(city)
    }
    override init() {
        super.init()
    }
    func getdata(latitude : CLLocationDegrees, longitude : CLLocationDegrees)
    {
        let manager = AFHTTPSessionManager()
        self.latitude = latitude
        self.longitude = longitude
        //var issucceed = true
        manager.GET(constants.url, parameters: ["lat":latitude,"lon":longitude,"appid": constants.id], success: { (DataTask, response) in
            self.isruning = false
            self.updateVar(response as! NSDictionary, id: 0)
            }) { (DataTask, error) in
                print(error)
                //issucceed = false
                self.city = "Sorry,can`t find the weather"
                self.tmp = ""
        }
//        return issucceed
    }
    func getdata(city : String)
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
        self.city = city
        manager.GET(constants.url, parameters: ["q":city,"appid": constants.id], success: { (DataTask, response) in
            self.isruning = false
            self.updateVar(response as! NSDictionary, id: 1)//if city id = 1
            
            
        }) { (DataTask, error) in
            print(error)
            //issucceed = false
            self.city = "Sorry,can`t find the weather"
            self.tmp = ""
        }
        
    }
    
    func updateVar(response : NSDictionary , id : Int)
    {
        iconparams = ""
        if let tem = response["main"]?["temp"] as? Double
        {
            var temporary : Double = 0
            if response["sys"]?["country"] as? String == "US"
            {
                temporary = round((tem - 273.15)*1.8 - 32)
            }
            else
            {
                temporary = round(tem - 273.15)
            }
            self.tmp = "\(temporary)℃"
            }
        else
        {
            self.tmp = "nil"
        }
        if let city = response["name"] as? String
        {
            if id == 0
            {
                self.city = city
            }
        }
        if let icon = response["weather"]?[0]["icon"] as? String
        {
            iconparams += constants.iconurl
            iconparams += icon
            iconparams += ".png"
            print(iconparams)
        }
        if id == 1
        {
            print(response["coord"]!["lon"])
            self.longitude = response["coord"]!["lon"] as! Double
            self.latitude = response["coord"]!["lat"] as! Double
        }
        
    }
    
}
