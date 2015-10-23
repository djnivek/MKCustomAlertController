//
//  PopViewController.swift
//  popovercontroller
//
//  Created by Kévin MACHADO on 22/10/2015.
//  Copyright © 2015 Kévin MACHADO. All rights reserved.
//

import UIKit

extension UIButton {
    
    func alertActionAssociated() -> MKAlertAction? {
        return objc_getAssociatedObject(self, "associatedObject") as? MKAlertAction
    }
    
    func addAction(action: MKAlertAction) {
        self.setTitle(action.title, forState: .Normal)
        self.setTitleColor(action.style == .Destructive ? UIColor.redColor() : UIColor.whiteColor(), forState: .Normal)
        objc_setAssociatedObject(self, "associatedObject", action, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
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

class PopViewController: UIViewController {
    
    private var _buttons = [UIButton]()
    
    //let verticalStackView = UIStackView()
    
    @IBOutlet weak var verticalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalStackView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for subview in view.subviews {
            verticalStackView.removeArrangedSubview(subview)
        }
        for button in _buttons {
            verticalStackView.addArrangedSubview(button)
        }
    }
    
    func addAction(action: MKAlertAction) {
        let button = UIButton(type: .System)
        button.frame = CGRectMake(0, 0, 200, 40)
        button.addAction(action)
        button.addTarget(self, action: "handleButtonPressed:", forControlEvents: UIControlEvents.TouchDown)
        _buttons.append(button)
        self.viewDidLayoutSubviews()
    }
    
    func generatePreferredSize() {
        var sizeHeight = CGFloat(0)
        var sizeWidth = CGFloat(0)
        for button in _buttons {
            sizeHeight += button.frame.height
            sizeHeight += 5
            sizeWidth = max(button.frame.width, sizeWidth)
        }
        self.preferredContentSize = CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    func handleButtonPressed(sender: UIButton) {
        print("handleButtonPressed")
        let action = sender.alertActionAssociated()
        let functionHandler = action?.handler
        functionHandler?()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentInViewController(sourceViewControllerThatPresent viewController: UIViewController, fromSourceView sourceView: UIView?, sourceRect: CGRect?, sourceBarButtonItem: UIBarButtonItem?) {
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
        if sourceRect != nil {
            self.popoverPresentationController?.sourceRect = sourceRect!
        }
        self.view.backgroundColor = UIColor.clearColor()
        self.popoverPresentationController?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.barButtonItem = sourceBarButtonItem
        generatePreferredSize()
        viewController.presentViewController(self, animated: true, completion: nil)
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
