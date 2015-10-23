//
//  ViewController.swift
//  popovercontroller
//
//  Created by Kévin MACHADO on 22/10/2015.
//  Copyright © 2015 Kévin MACHADO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(sender: UIButton) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PopViewController") as! PopViewController
        popController.addAction(MKAlertAction(title: "Button1", style: .Default, handler: { () -> Void in
            print("Ok c'est bon")
        }))
        popController.addAction(MKAlertAction(title: "Button2", style: .Default, handler: { () -> Void in
            print("Ok d'accord")
        }))
        popController.presentInViewController(sourceViewControllerThatPresent: self, fromSourceView: sender, sourceRect: sender.bounds, sourceBarButtonItem: nil)
    }
}

