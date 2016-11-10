//
//  MKGPX.swift
//  trax
//
//  Created by bossxuan on 16/10/22.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import MapKit
class EditableWaypoint: GPX.Waypoint
{
    override var coordinate: CLLocationCoordinate2D
        {
        get{return super.coordinate}
        set
        {
            self.latitude = newValue.latitude
            self.longitude = newValue.longitude
        }
    }
    override var trumbnailURL: NSURL? {return imageURL}
    override var imageURL: NSURL? {return links.first?.url}
}
extension GPX.Waypoint : MKAnnotation{
    var coordinate : CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var title : String? {
        return name
    }
    var subtitle : String?{
        return info
    }
    var trumbnailURL :NSURL? {return getImageUrlofType("thumbnail")}
    var imageURL :NSURL? {return getImageUrlofType("large")}
    func getImageUrlofType(type : String) -> NSURL? {
        for link in links
        {
            if link.type == type
            {
                    return link.url
            }
        }
        return nil
    }
}