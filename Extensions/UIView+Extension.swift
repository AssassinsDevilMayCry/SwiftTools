//
//  UIView+Extension.swift
//  Swift-Extensions
//
//  Created by xhl on 2021/7/26.
//

import Foundation
import UIKit

var ViewTapActionKey = "ViewTapActionKey"
var ViewLongActionKey = "ViewLongActionKey"

extension UIView {

    public var tapAction : ( () -> Void )?{
        get{
            return objc_getAssociatedObject(self, &ViewTapActionKey) as? () -> Void
        }
        set{
            objc_setAssociatedObject(self,  &ViewTapActionKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 添加tap事件
    /// - Parameters:
    ///   - numberOfTapsRequired: 轻点次数
    ///   - numberOfTouchesRequired: 手指个数
    ///   - action:  tap事件尾随闭包
    public func addTapGesture(numberOfTapsRequired : Int = 1,
                       numberOfTouchesRequired : Int = 1,
                       action:@escaping()->Void) {
        
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction(action:)))
        tapAction = action
        tapGes.numberOfTapsRequired = numberOfTapsRequired //轻点次数
        tapGes.numberOfTouchesRequired = numberOfTouchesRequired //手指个数
        self.addGestureRecognizer(tapGes)
    }
    
    @objc func tapAction(action : UITapGestureRecognizer) {
        if let action = tapAction { action() }
    }
}

extension UIView {

    public var longAction : ( () -> Void )?{
        get{
            return objc_getAssociatedObject(self, &ViewLongActionKey) as? () -> Void
        }
        set{
            objc_setAssociatedObject(self,  &ViewLongActionKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 添加长按事件
    /// - Parameters:
    ///   - minimumPressDuration: 长按触发的时间
    ///   - action: long事件尾随闭包
    public func addLongGesture(minimumPressDuration : TimeInterval = 1,
                        action:@escaping()->Void) {
        
        self.isUserInteractionEnabled = true
        let ges = UILongPressGestureRecognizer(target: self, action: #selector(longAction(action:)))
        longAction = action
        ges.minimumPressDuration = minimumPressDuration
        self.addGestureRecognizer(ges)
    }
    
    @objc func longAction(action : UITapGestureRecognizer) {
        if let action = longAction { action() }
    }
}
extension UIView {
    
    func setX(_ x:CGFloat){
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    func setY(_ y:CGFloat){
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    func setWidth(_ width:CGFloat){
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
    }
    func setHeight(_ height:CGFloat){
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
}

