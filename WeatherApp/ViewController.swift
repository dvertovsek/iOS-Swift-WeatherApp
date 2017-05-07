//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dare on 18/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import SearchTextField

class ViewController: UIViewController {

    @IBOutlet weak var mySearchTextField: SearchTextField!

    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let places = dataManager.allPlaces
        mySearchTextField.filterStrings(places.map{ $0.name })
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
