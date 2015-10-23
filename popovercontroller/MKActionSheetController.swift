//
//  MKActionSheetController.swift
//  popovercontroller
//
//  Created by Kévin MACHADO on 23/10/2015.
//  Copyright © 2015 Kévin MACHADO. All rights reserved.
//

import UIKit

class MKActionSheetController: UITableViewController {
    
    class MKAlertAction {
        
        enum MKAlertActionStyle {
            case Default
            case Destructive
            case Cancel
        }
        
        var title: String
        var style: MKAlertActionStyle = .Default
        var handler: (() -> Void)?
        
        init(title: String, style: MKAlertActionStyle?, handler: (()-> Void)?) {
            self.title = title
            if style != nil {
                self.style = style!
            }
            self.handler = handler
        }
    }
    
    private var _actions = [MKAlertAction]()
    
    var actions: [MKAlertAction] {
        return _actions
    }
    
    func addAction(action: MKAlertAction) {
        _actions.append(action)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.scrollEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.grayColor()
        self.view.superview?.layer.cornerRadius = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _actions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        let action = _actions[indexPath.item]
        cell.textLabel?.text = action.title
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.textColor = action.style == .Destructive ? UIColor.redColor() : UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let functionHandler = _actions[indexPath.item].handler
        functionHandler?()
    }
    
    func generatePreferredSize() {
        var sizeHeight = CGFloat(0)
        var sizeWidth = CGFloat(0)
        for action in _actions {
            sizeHeight += CGRectGetHeight(tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!.frame)
            sizeWidth = max(150, max(CGFloat(action.title.characters.count) * 13.5, sizeWidth))
        }
        self.preferredContentSize = CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    func presentInViewController(sourceViewControllerThatPresent viewController: UIViewController, fromSourceView sourceView: UIView?, sourceRect: CGRect?, sourceBarButtonItem: UIBarButtonItem?) {
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
        if sourceRect != nil {
            self.popoverPresentationController?.sourceRect = sourceRect!
        }
        self.view.backgroundColor = UIColor.clearColor()
        self.popoverPresentationController?.backgroundColor = UIColor.grayColor()
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.barButtonItem = sourceBarButtonItem
        generatePreferredSize()
        viewController.presentViewController(self, animated: true, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
