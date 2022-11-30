//
//  MenuBarController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit
import SOTabBar

class MenuBarController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpTabsControllers()
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 50.0, height: 50.0)
           // or
        //SOTabBarSetting.tabBarCircleSize = CGSize(width: 80.0, height: 80.0)
    }
    
    func SetUpTabsControllers(){
        
        let story_board = UIStoryboard(name: "Main", bundle: nil)
        let home_view_controller = story_board.instantiateViewController(withIdentifier: "home")
        let emotional_memo_controller = story_board.instantiateViewController(withIdentifier: "emotionalmemo")
        let counseling_controller = story_board.instantiateViewController(withIdentifier: "counseling")
        let life_rhythm_controller = story_board.instantiateViewController(withIdentifier: "liferhythm")
        let medicine_controller = story_board.instantiateViewController(withIdentifier: "medicine")
        let stress_controller = story_board.instantiateViewController(withIdentifier: "stress")
        let hospital_visit_date_controller = story_board.instantiateViewController(withIdentifier: "hospitalvisitdate")
        let meditation_controller = story_board.instantiateViewController(withIdentifier: "meditation")
        
        home_view_controller.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named: "home_2"), selectedImage: UIImage(named: "HomeImage"))
        emotional_memo_controller.tabBarItem = UITabBarItem(title: "感情のメモ", image: UIImage(named: "EmotionalMemo"), selectedImage: UIImage(named: "EmotionalMemo"))
        counseling_controller.tabBarItem = UITabBarItem(title: "相談したいこと", image: UIImage(named: "counseling"), selectedImage: UIImage(named: "Counseling"))
        life_rhythm_controller.tabBarItem = UITabBarItem(title: "生活リズム", image: UIImage(named: "life_rhythm"), selectedImage: UIImage(named: "LifeRhythm"))
        medicine_controller.tabBarItem = UITabBarItem(title: "薬", image: UIImage(named: "medicine"), selectedImage: UIImage(named: "Medicine"))
        stress_controller.tabBarItem = UITabBarItem(title: "ストレス", image: UIImage(named: "stress"), selectedImage: UIImage(named: "Stress"))
        hospital_visit_date_controller.tabBarItem = UITabBarItem(title: "通院日", image: UIImage(named: "hospital"), selectedImage: UIImage(named: "Hospital"))
        meditation_controller.tabBarItem = UITabBarItem(title: "瞑想", image: UIImage(named: "mediation"), selectedImage: UIImage(named: "Meditation"))
        
        
        viewControllers = [home_view_controller, emotional_memo_controller, counseling_controller, life_rhythm_controller, medicine_controller, stress_controller, hospital_visit_date_controller, meditation_controller]
       
    }
}
