//
//  LifeRhythmViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit
import MaterialComponents
import CLTimer
import AVFoundation

class LifeRhythmViewController: UIViewController {

    // UIパーツはリファクタリング時にコード化する
    @IBOutlet weak var alarm_card: MDCCard!
    @IBOutlet weak var wake_up_date_picker: UIDatePicker!
    @IBOutlet weak var bed_time_date_picker: UIDatePicker!
    @IBOutlet weak var focus_timer: CLTimer!
    var player: AVAudioPlayer?
    
    let bed_time_alarm = Alarm()
    let wake_up_time_alarm = Alarm()
    
    fileprivate var focus_time = Int()
    fileprivate var interval_time = Int()
    fileprivate var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alarm_card.setBorderColor(.blue, for: .normal)
        alarm_card.setBorderWidth(3.0, for: .normal)
        alarm_card.setShadowColor(.blue, for: .normal)
        
        bed_time_date_picker.datePickerMode = UIDatePicker.Mode.time
        bed_time_date_picker.setDate(Date(), animated: false)
        
        wake_up_date_picker.datePickerMode = UIDatePicker.Mode.time
        wake_up_date_picker.setDate(Date(), animated: false)
        
        // 25分間集中
        focus_time = 1500
        // 10分間休憩
        interval_time = 600
    }

    override func viewDidAppear(_ animated: Bool) {
        if wake_up_time_alarm.sleepTimer != nil{
            wake_up_time_alarm.stopTimer()
        }
        
        if bed_time_alarm.sleepTimer != nil{
            bed_time_alarm.stopTimer()
        }
    }
    
    @IBAction func SettingTimeSave(_ sender: Any) {
        
        //AlarmにあるselectedWakeUpTimeにユーザーの入力した日付を代入
        wake_up_time_alarm.selectedWakeUpTime = wake_up_date_picker.date
        bed_time_alarm.selectedWakeUpTime = bed_time_date_picker.date
        //AlarmのrunTimerを呼ぶ
        wake_up_time_alarm.runTimer()
        bed_time_alarm.runTimer()
    }
    
    @IBAction func StartTimer(_ sender: Any) {
        
        focus_timer.startTimer(withSeconds: focus_time, format: .Minutes, mode: .Forward)
        // 25分間集中
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.focus_time -= 1

            if self.focus_time == 0 {
                self.PlaySound()
            }
        })
        
    }
    
    // リファクタリングでクラス化する
    private func PlaySound(){
        
        if let soundURL = Bundle.main.url(forResource: "Cuckoo_Clock01-12(Far-Long)", withExtension: ".mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOf: soundURL)
                self.player?.play()
            } catch {
                print("error")
            }
        }
    }
    
    // タイマーを止める
    @IBAction func StopTimer(_ sender: Any) {
        focus_timer.stopTimer()
    }
    
    @IBAction func InterValTimer(_ sender: Any) {
        // 10分間休憩
        focus_timer.startTimer(withSeconds: interval_time, format: .Minutes, mode: .Forward)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.interval_time -= 1

            if self.interval_time == 0 {
                self.PlaySound()
            }
        })
    }
    
}
