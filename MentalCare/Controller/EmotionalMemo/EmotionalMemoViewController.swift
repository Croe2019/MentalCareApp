//
//  EmotionalMemoViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit
import SwipeCellKit

class EmotionalMemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var sample_array = ["a", "b", "c"]
    
    //スクリーンの横幅、縦幅を定義
    let screenWidth = Int(UIScreen.main.bounds.size.width)
    let screenHeight = Int(UIScreen.main.bounds.size.height)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = CGRect(x:screenWidth * 0/100, y:screenHeight * 10/100, width:screenWidth * 100/100, height:screenHeight * 80/100)
        
        //cellの高さを指定
        self.tableView.rowHeight = 100
        //セパレーターの色を指定
        tableView.separatorColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sample_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        cell.textLabel?.text = sample_array[indexPath.row]
        return cell
    }
    
    //swipecellkit swipetableviewdelegateのメソッド
    //スワイプした際に表示される文字や画像を設定。またタップした際の処理も設定
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //右スワイプをした際の処理。今回は何も処理を行わない。
        guard orientation == .right else { return nil }

        //左スワイプした際の処理。
        let deleteAction = SwipeAction(style: .destructive, title: "削除") { action, indexPath in
            //cellの状態を解除する処理。必須の処理。
            action.fulfill(with: .reset)

            /*********************************/
            let alert: UIAlertController = UIAlertController(title: "Cellを削除", message: "削除してもよろしいでしょうか？", preferredStyle:  UIAlertController.Style.alert)

            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
                self.sample_array.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            })

            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            /*********************************/

        }
        //スワイプした際に表示される画像の設定。
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }

    //スワイプ時の表示形式の設定。SwipeCellKitの公式サイトを見ると一発でわかる。
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }

    
}

