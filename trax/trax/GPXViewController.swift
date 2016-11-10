//
//  ViewController.swift
//  trax
//
//  Created by bossxuan on 16/10/22.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
import MapKit
class GPXViewController: UIViewController,MKMapViewDelegate,UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var mapView: MKMapView!
        {
        didSet{
            mapView.mapType = .Standard
            mapView.delegate = self
        }
    }
    
    @IBAction func addwaypoint(sender: UILongPressGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Began
        {
            let coordinate = mapView.convertPoint(sender.locationInView(mapView), toCoordinateFromView: mapView)//将屏幕上的坐标转换成经纬度
            let waypoint = EditableWaypoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
            waypoint.name = "press"
//            waypoint.links.append(GPX.Link(href: "http://cs193p.stanford.edu/Images/Panorama.jpg"))	
            mapView.addAnnotation(waypoint)
        }
    }
    
    
    
    var gpxURL : NSURL?
    {
        didSet
        {
            clearWaypoints()
            if let url = gpxURL
            {
                GPX.parse(url)
                {
                    if let gpx = $0
                    {
                        self.handleWaypoints(gpx.waypoints)
                    }
                }
            }
        }
    }
    struct constans {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "waypoint"
        static let ShowImageSegue = "Show Image"
        static let EditWaypointsegue = "edit segue"
    }
    func handleWaypoints(waypoints: [GPX.Waypoint]) -> Void {
        mapView.addAnnotations(waypoints)
        mapView.showAnnotations(waypoints, animated: true)
    }
    func clearWaypoints(){
        if mapView?.annotations != nil{ mapView.removeAnnotations(mapView.annotations as [MKAnnotation])}
    }
    // MARK : - MKmapviewdelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(constans.AnnotationViewReuseIdentifier)
        if view == nil
        {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: constans.AnnotationViewReuseIdentifier)
            view!.canShowCallout = true
        }
        else {
            view?.annotation = annotation
        }
        view?.draggable = annotation is EditableWaypoint
       
        if let gpxway = annotation as? GPX.Waypoint
        {
            if gpxway.trumbnailURL != nil
            {
                view?.leftCalloutAccessoryView = UIButton(frame: constans.LeftCalloutFrame)
                
            }
            if annotation is EditableWaypoint
            {
                view?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
          
        }
        return view
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let waypoint = view.annotation as? GPX.Waypoint
        {
            if let imageView = view.leftCalloutAccessoryView as? UIButton
            {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
                {
                    let imagedata = NSData(contentsOfURL: waypoint.trumbnailURL!)
                    if imagedata != nil
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            if let image = UIImage(data: imagedata!)
                            {
                                imageView.setImage(image, forState: .Normal)
                            }
                        }
                    }
                }
                /*if let imagedata = NSData(contentsOfURL: waypoint.trumbnailURL!)
                {
                    if let image = UIImage(data: imagedata)
                    {
                        imageView.image = image
                    }
                }*/
            }
        }
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as! UIButton).buttonType == .DetailDisclosure
        {
            mapView.deselectAnnotation(view.annotation, animated: false)//使其变为非选中状态保证返回后更新数据	
            performSegueWithIdentifier(constans.EditWaypointsegue, sender: view)
        }
        else if let waypoint = view.annotation as? GPX.Waypoint
        {
            if waypoint.imageURL != nil
            {
                performSegueWithIdentifier(constans.ShowImageSegue, sender: view)
            }
        }
    }
    // MARK : - segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if  segue.identifier == constans.ShowImageSegue
        {
            if let nvc = segue.destinationViewController.contentViewController as? ImageViewController
            {
                if let waypoint = ((sender as? MKAnnotationView)?.annotation as? GPX.Waypoint)
                {
                    nvc.imageURL = waypoint.imageURL
                    nvc.title = waypoint.title
                }
            }
        }
        if segue.identifier == constans.EditWaypointsegue
        {
            if let nvc = segue.destinationViewController.contentViewController as? EditViewController
            {
                if let waypoint = ((sender as? MKAnnotationView)?.annotation as? EditableWaypoint)
                {
                    if let ppc = nvc.popoverPresentationController
                    {
                        let cordinate = mapView.convertCoordinate(waypoint.coordinate, toPointToView: mapView)//将经纬度坐标转换成屏幕上的坐标
                        ppc.sourceRect = ((sender as! MKAnnotationView).popoverSourceRectForCoordinatePoint(cordinate))
                        let min = nvc.view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)//适应元素的最小尺寸
                        nvc.preferredContentSize = CGSize(width: 320, height: min.height)
                        ppc.delegate = self
                    }
                    nvc.waypoint = waypoint
                }

            }
        }
        
    }
    // MARK : - popoverpresentationControllerdeleget
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.OverFullScreen
    }
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
    // MARK : - viewcontrollerlifecicyle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gpxURL = NSURL(string: "http://cs193p.stanford.edu/Vacation.gpx")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
// MARK : - extension
extension UIViewController {
    var contentViewController : UIViewController{
        if let nvc = self as? UINavigationController
        {
            return nvc.visibleViewController!
        }else
        {
            return self
        }
    }
}
extension MKAnnotationView{
    func popoverSourceRectForCoordinatePoint(coordinatePoint : CGPoint)->CGRect
    {
        var popoverSourceRectCenter = coordinatePoint
        popoverSourceRectCenter.x -= frame.width/2 - centerOffset.x - calloutOffset.x
        popoverSourceRectCenter.y -= frame.height/2 - centerOffset.y - calloutOffset.y
        return CGRect(origin: popoverSourceRectCenter, size: frame.size)
        
    }
}

