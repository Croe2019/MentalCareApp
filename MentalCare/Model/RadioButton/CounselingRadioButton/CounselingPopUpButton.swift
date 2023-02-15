//
//  CounselingRadioButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/01.
//

import Foundation
import YSRadioButton
import SnapKit
import Material

@available(iOS 14.0, *)
class CounselingPopUpButton{
    
    enum MenuType: String{
        case completed = "相談済み"
        case incomplete = "未相談"
    }
    fileprivate var select_menu_type = MenuType.completed
    
    public func GetMenuType() -> String{
        return select_menu_type.rawValue
    }
    
    @available(iOS 15.0, *)
    public func PopUpButtonSetting(button: UIButton){
        ConfigureMenuButton(button: button)
        
        button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(600)
        }
    }
    
    @available(iOS 15.0, *)
    private func ConfigureMenuButton(button: UIButton) {
        
        var actions = [UIMenuElement]()
        // HIGH
        actions.append(UIAction(title: MenuType.completed.rawValue, image: nil, state: self.select_menu_type == MenuType.completed ? .on : .off,
                                handler: { (_) in
                                    self.select_menu_type = .completed
                                    // UIActionのstate(チェックマーク)を更新するためにUIMenuを再設定する
            self.ConfigureMenuButton(button: button)
                                }))
        // MID
        actions.append(UIAction(title: MenuType.incomplete.rawValue, image: nil, state: self.select_menu_type == MenuType.incomplete ? .on : .off,
                                handler: { (_) in
                                    self.select_menu_type = .incomplete
                                    // UIActionのstate(チェックマーク)を更新するためにUIMenuを再設定する
            self.ConfigureMenuButton(button: button)
                                }))

        // UIButtonにUIMenuを設定
        button.menu = UIMenu(title: "", options: .displayInline, children: actions)
        button.backgroundColor = .tintColor
        // こちらを書かないと表示できない場合があるので注意
        button.showsMenuAsPrimaryAction = true
        // ボタンの表示を変更
        button.setTitle(self.select_menu_type.rawValue, for: .normal)
    }
}
