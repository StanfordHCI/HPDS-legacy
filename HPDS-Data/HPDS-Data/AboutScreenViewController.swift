//
//  AboutScreenViewController.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-20.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit

class AboutScreenViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Constrain ScrollView to bottom anchor
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
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
