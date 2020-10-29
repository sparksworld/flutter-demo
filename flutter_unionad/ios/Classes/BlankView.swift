//
//  BlankView.swift
//  flutter_unionad
//
//  Created by 余振泉 on 2020/10/29.
//

import Foundation
import UIKit
//继承UIView
class BlankView : UIView, UIGestureRecognizerDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景为灰色
//        _ = UITapGestureRecognizer(target:self,)
//        self.addGestureRecognizer()
        self.isUserInteractionEnabled =  true
        self.backgroundColor = UIColor.gray
        
        let tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        tap.delegate = self
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchView:UIView = UIApplication.shared.keyWindow!.perform(Selector(("firstResponder")));
        let test = NSStringFromClass(type(of: self))
        print(test)
        if NSStringFromClass(type(of: self)) == "flutter_unionad.BlankView" {
            self.isUserInteractionEnabled =  false
        }
        self.isUserInteractionEnabled =  true
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled =  true
    }
    
    //自动布局
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass(type(of: touch.view!).self) == "FlutterView" {
                return false
            }
            return true
    }
}
