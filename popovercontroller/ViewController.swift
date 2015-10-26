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
        let popController = MKAlertController(style: .ActionSheet)
        popController.addAction(MKAlertController.MKAlertAction(title: "Button1", style: .Default, handler: { () -> Void in
            print("Ok c'est bon")
        }))
        popController.addAction(MKAlertController.MKAlertAction(title: "Button2", style: .Destructive, handler: { () -> Void in
            print("Ok d'accord")
        }))
        popController.presentInViewController(sourceViewControllerThatPresent: self, fromSourceView: sender, sourceRect: sender.bounds, sourceBarButtonItem: nil)
    }
    
    @IBAction func secondButtonAction(sender: UIButton) {
        let popController = MKAlertController(style: .Alert)
        popController.addAction(MKAlertController.MKAlertAction(title: "Prendre une photo", style: .Default, handler: { () -> Void in
            print("Souriez !! Photo")
        }))
        popController.addAction(MKAlertController.MKAlertAction(title: "Prendre une vidéo", style: .Default, handler: { () -> Void in
            print("C'est dans la boite ! ;)")
        }))
        popController.addAction(MKAlertController.MKAlertAction(title: "Annuler", style: .Cancel, handler: { () -> Void in
            print("Dommage")
        }))
        popController.presentInViewController(sourceViewControllerThatPresent: self)
    }
    
}

