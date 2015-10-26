//
//  MKAlertController.swift
//  popovercontroller
//
//  Created by Kévin MACHADO on 23/10/2015.
//  Copyright © 2015 Kévin MACHADO. All rights reserved.
//

import UIKit

class MKAlertController: UITableViewController {
    
    private weak var sourceViewController: UIViewController!
    private var bluredView: UIView?
    
    enum MKAlertActionStyle {
        case ActionSheet
        case Alert
    }
    
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
    
    var style: MKAlertActionStyle
    
    private var _actions = [MKAlertAction]()
    
    var actions: [MKAlertAction] {
        return _actions
    }
    
    init(style: MKAlertActionStyle) {
        self.style = style
        if style == .Alert {
            super.init(style: .Grouped)
        } else {
            super.init(style: .Plain)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        style = .Alert
        super.init(coder: aDecoder)
    }
    
    func addAction(action: MKAlertAction) {
        _actions.append(action)
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame.size = preferredSize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.scrollEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.whiteColor()
        if style == .Alert {
            self.view.superview?.layer.cornerRadius = 6
        } else {
            self.view.superview?.layer.cornerRadius = 2
        }
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
        cell.textLabel?.textColor = action.style == .Destructive ? UIColor.redColor() : (action.style == .Cancel ? UIColor.blueColor() : UIColor.blackColor())
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let functionHandler = _actions[indexPath.item].handler
        functionHandler?()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func preferredSize() -> CGSize {
        var sizeHeight = CGFloat(0)
        var sizeWidth = CGFloat(0)
        
        if style == .Alert {
            sizeHeight += 50
        }
        
        for action in _actions {
            sizeHeight += CGRectGetHeight(tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!.frame)
            sizeWidth = max(150, max(CGFloat(action.title.characters.count) * 13.5, sizeWidth))
        }
        
        return CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    private func setPreferredSize(size: CGSize) {
        self.preferredContentSize = size
    }
    
    func presentInViewController(sourceViewControllerThatPresent viewController: UIViewController) {
        sourceViewController = viewController
        self.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        setPreferredSize(preferredSize())
        sourceViewController.presentViewController(self, animated: true, completion: nil)
    }
    
    func presentInViewController(sourceViewControllerThatPresent viewController: UIViewController, fromSourceView sourceView: UIView?, sourceRect: CGRect?, sourceBarButtonItem: UIBarButtonItem?) {
        
        if style == .Alert {
            self.presentInViewController(sourceViewControllerThatPresent: viewController)
            return
        }
        
        sourceViewController = viewController
        
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
        if sourceRect != nil {
            self.popoverPresentationController?.sourceRect = sourceRect!
        }
        self.view.backgroundColor = UIColor.clearColor()
        self.popoverPresentationController?.backgroundColor = UIColor.whiteColor()
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.barButtonItem = sourceBarButtonItem
        self.popoverPresentationController?.delegate = self
        setPreferredSize(preferredSize())
        
        sourceViewController.presentViewController(self, animated: true, completion: nil)
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

extension MKAlertController: UIPopoverPresentationControllerDelegate {
    
    func prepareForPopoverPresentation(popoverPresentationController: UIPopoverPresentationController) {
        let blured = UIBlurEffect(style: .Light)
        bluredView = UIVisualEffectView(effect: blured)
        bluredView!.frame = sourceViewController.view.frame
        bluredView?.alpha = 0.0
        sourceViewController.view.addSubview(bluredView!)
        UIView.animateWithDuration(0.3) { () -> Void in
            bluredView?.alpha = 0.8
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            bluredView?.alpha = 0
            }) { (finished) -> Void in
                bluredView?.removeFromSuperview()
        }
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        super.dismissViewControllerAnimated(flag, completion: completion)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            bluredView?.alpha = 0
            }) { (finished) -> Void in
                bluredView?.removeFromSuperview()
        }
    }
    
}
