//
//  MBProgressHUD+Extension.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/19.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import Foundation
import UIKit

extension MBProgressHUD {
    class func showDelayHUDToView(view: UIView, mess: String?, icon: String?) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        //hud.yOffset = Float(view.frame.size.height) / 6;
        hud.mode = MBProgressHUDMode.CustomView
        hud.removeFromSuperViewOnHide = true
        hud.labelText = mess;
        hud.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        if icon != nil {
            hud.customView = UIImageView(image: UIImage(named: icon!))
        } else {
            hud.customView = UIImageView(frame: CGRectZero)
        }
        hud.hide(true, afterDelay: 2.0)
    }
    
    class func showToView(view: UIView, mess: String, icon: String?) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = mess;
        hud.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    }
    
    class func hideFromView(view: UIView) {
        self.hideHUDForView(view, animated: true)
    }
    
    class func showLoadingHUDToView(view: UIView, icon: String?) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.CustomView
        hud.customView = LoadingAnmationView(frame: CGRectMake(0, 0, 50, 40))
        hud.color = UIColor(red: 225/255, green: 225/255, blue: 230/255, alpha: 1)
        hud.labelText = "loading..."
        hud.labelColor = UIColor.blackColor()
        hud.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    }
    class func hideLoadingHUDToView(view: UIView) {
        self.hideFromView(view)
    }
    
    class func showLoadingErr(view: UIView, icon: String?) {
        self.showDelayHUDToView(view, mess: "loading fail...", icon: nil)
    }
}