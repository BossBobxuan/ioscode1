//
//  CityTableViewController.swift
//  weather
//
//  Created by bossxuan on 16/11/5.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
protocol updateuserdefaultdelegate {
    func updateuserdefault()
}
class CityTableViewController: UITableViewController {
    var datamodels = [locationsub]()
    var alert = UIAlertController(title: "city", message: "please join the city", preferredStyle: .Alert)
    let defalut = NSUserDefaults.standardUserDefaults()
    var delegate : updateuserdefaultdelegate?
    func edit()
    {
        presentViewController(alert, animated: true) { 
            
        }
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
            
            self.tableView.reloadData()
            
        }) { (DataTask, error) in
            print(error)
            //issucceed = false
            model.city = "Sorry,can`t find the weather"
            model.tmp = ""
        }
        
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityname  = defalut.objectForKey("cityname") as? NSArray
        {
            print("YES")
            for index in cityname
            {
                print("YES2")
                let string = index as! String
                let model = locationsub()
                self.getdata(string, model: model)
                datamodels.append(model)
            }
        }
        let editbar = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "edit")
        self.navigationItem.setRightBarButtonItem(editbar, animated: true)
        alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: nil))
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "city"
        }
        alert.addAction(UIAlertAction(title: "submit", style: .Default, handler: { (action) in
            let field = self.alert.textFields?[0] as UITextField?
            if field != nil
            {
                let model = locationsub()
                self.getdata((field?.text)!, model: model)
                self.datamodels.append(model)
              
               
            }
        }))
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidDisappear(animated: Bool) {
        
            super.viewDidDisappear(animated)
            defalut.removeObjectForKey("cityname")
            var str : NSArray = NSArray()
            for model in self.datamodels
            {
                print("222")
                str = str.arrayByAddingObject(model.city)
            }
            defalut.setObject(str, forKey: "cityname")
            delegate!.updateuserdefault()
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datamodels.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("default", forIndexPath: indexPath)//需要在属性面板添加identify

        // Configure the cell...
        cell.textLabel!.text = datamodels[indexPath.row].title!
        cell.detailTextLabel!.text = datamodels[indexPath.row].subtitle!
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

        // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.datamodels.removeAtIndex(indexPath.row)//必须和cellForRowatINdexPath返回的值一致，需要实时更新model
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            
        }
//        tableView.reloadData()
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
