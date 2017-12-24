//
//  ContainingViewController.swift
//  TFGMLive
//
//  Created by Christopher Winstanley on 24/12/2017.
//  Copyright © 2017 Winstanley. All rights reserved.
//

import UIKit

class ContainingViewController: UIViewController {

    var station: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tramsTableViewController = childViewControllers.first as! TramsTableViewController
        tramsTableViewController.station = station
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
