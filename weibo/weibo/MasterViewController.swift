//
//  MasterViewController.swift
//  weibo
//
//  Created by bossxuan on 16/11/8.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ModelDelegate,UIGestureRecognizerDelegate {

    var detailViewController: DetailViewController? = nil
    var model: Model?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        model = Model(delegate: self)
        model!.synchronize()
    }
    func addButtonPressed(sender : AnyObject)
    {
        displayAddEditSearchAlert(true, index : nil)
    }
    func tableViewCellLongPressed(sender: UILongPressGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.Began && !tableView.editing
        {
            let cell = sender.view as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell)
            {
                displayLongPressOptions(indexPath.row)
            }
            
        }
    }
    func displayAddEditSearchAlert(isNew : Bool, index : Int?) -> Void {
        let alert = UIAlertController(title: isNew ? "Add Search" : "Edit Search", message: isNew ? "" : "edit", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            if isNew
            {
                textField.placeholder = "Enter search"
            }else
            {
                textField.text = self.model?.stringAtIndex(index!)
            }
        }
        alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) in
           let search = ((alert.textFields?[0])! as UITextField).text
            if search != nil && !(search?.isEmpty)!
            {
                self.model?.insertSearch(search!,index: index)
            }
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    func displayLongPressOptions(row : Int) -> Void {
        let alert = UIAlertController(title: "Options", message: "Edit or Share your search", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Edit", style: .Default, handler: { (action) in
            self.displayAddEditSearchAlert(false, index : row)
        }))
        alert.addAction(UIAlertAction(title: "Share", style: .Default, handler: { (action) in
            self.shareSearch(row)
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    func shareSearch(index : Int) -> Void {
        let message = "Check out"
        let url = "https://m.baidu.com/s?ie=UTF-8&tn=null&wd="
        let activity = UIActivityViewController(activityItems: [message,url + (model?.stringAtIndex(index))!], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.title = model?.stringAtIndex(indexPath.row)
                controller.url = (model?.stringAtIndex(indexPath.row))!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        
        cell.textLabel!.text = model?.stringAtIndex(indexPath.row)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "tableViewCellLongPressed:")
        longPressGestureRecognizer.minimumPressDuration = 0.5
        cell.addGestureRecognizer(longPressGestureRecognizer)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            model?.deleteSearchAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        model?.move(sourceIndexPath.row, toDestinationIndex : destinationIndexPath.row)
    }
    // MARK: - delegate
    func modelDataChanged() {
        tableView.reloadData()
    }

}

