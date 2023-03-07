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
       // let home_view_controller = story_board.instantiateViewController(withIdentifier: "home")
        let emotional_memo_controller = story_board.instantiateViewController(withIdentifier: "emotionalmemo")
        let counseling_controller = story_board.instantiateViewController(withIdentifier: "counseling")
        let life_rhythm_controller = story_board.instantiateViewController(withIdentifier: "liferhythm")
        
        //home_view_controller.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(named: "home_2"), selectedImage: UIImage(named: "HomeImage"))
        emotional_memo_controller.tabBarItem = UITabBarItem(title: "感情のメモ", image: UIImage(named: "EmotionalMemo"), selectedImage: UIImage(named: "EmotionalMemo"))
        counseling_controller.tabBarItem = UITabBarItem(title: "相談したいこと", image: UIImage(named: "counseling"), selectedImage: UIImage(named: "Counseling"))
        life_rhythm_controller.tabBarItem = UITabBarItem(title: "生活リズム", image: UIImage(named: "life_rhythm"), selectedImage: UIImage(named: "LifeRhythm"))
        
        
        viewControllers = [emotional_memo_controller, counseling_controller, life_rhythm_controller]
       
    }
}
