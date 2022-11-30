//
//  MedicineViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit

class MedicineViewController: UIViewController {

    var home_label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        home_label.text = "薬の量"
        home_label.frame = CGRect(x: 50, y: 300, width: 300, height: 200)
        home_label.fontSize = 40
        view.addSubview(home_label)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
