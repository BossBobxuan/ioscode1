//
//  EditViewController.swift
//  trax
//
//  Created by bossxuan on 16/10/23.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var waypoint : EditableWaypoint? {didSet{updateUI()}}
    @IBOutlet weak var infoField: UITextField!{didSet{infoField.delegate = self}}
    @IBOutlet weak var nameField: UITextField!{didSet{nameField.delegate = self}}
    var a : NSObjectProtocol?
    var b : NSObjectProtocol?
    func updateUI()
    {
        if let waypoint = waypoint
        {
            nameField?.text = (waypoint.name)
            infoField?.text = (waypoint.info)
            updateImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameField.becomeFirstResponder()
        updateUI()
    }
    @IBAction func done(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        a = center.addObserverForName(UITextFieldTextDidChangeNotification, object: nameField, queue: queue) { (notification) in
            if let waypoint = self.waypoint
            {
                waypoint.name = self.nameField!.text
            }
        }
  
        b = center.addObserverForName(UITextFieldTextDidChangeNotification, object: infoField, queue: queue) { (notification) in
            if let waypoint = self.waypoint
            {
                waypoint.info = self.infoField!.text
            }
        }

        
    }
    override func viewWillDisappear(animated: Bool) {
        if let ob = a
        {
            NSNotificationCenter.defaultCenter().removeObserver(ob)
        }
        
        if let ob = b
        {
            NSNotificationCenter.defaultCenter().removeObserver(ob)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var imageView = UIImageView()
    @IBOutlet weak var ImageViewcontiner: UIView!
        {
        didSet{ImageViewcontiner.addSubview(imageView)}
    }
    @IBAction func Takephoto()
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            let picker = UIImagePickerController()
            picker.mediaTypes = [kUTTypeImage as String]
            picker.sourceType = .Camera
            picker.delegate = self
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image = info[UIImagePickerControllerEditedImage] as? UIImage
        if image == nil
        {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        imageView.image = image
        makeRoomForImage()
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EditViewController
{
    func updateImage()
    {
        if let url = waypoint?.imageURL
        {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0))
            {
                [weak self] in
                if let imageData = NSData(contentsOfURL: url)
                {
                    if url == self?.waypoint?.imageURL
                    {
                        if let image = UIImage(data: imageData)
                        {
                            dispatch_async(dispatch_get_main_queue()) {
                                self?.imageView.image = image
                                self?.makeRoomForImage()
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    func makeRoomForImage()
    {
        var extraHeight : CGFloat = 0
        if imageView.image?.aspectRatio > 0
        {
            if let width = imageView.superview?.frame.size.width
            {
                let height = width / imageView.image!.aspectRatio
                extraHeight = height - imageView.frame.height
                imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            }
        }else
        {
            extraHeight = -imageView.frame.height
            imageView.frame = CGRectZero
        }
        preferredContentSize = CGSize(width: preferredContentSize.width, height: preferredContentSize.height + extraHeight)
    }
}
extension UIImage
{
    var aspectRatio : CGFloat
        {
        return size.height != 0 ? size.width / size.height : 0
    }
}
