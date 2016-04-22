//
//  MyDetailViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/5.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

@objc
protocol AbsViewFactoryDelegete {
    optional func createControl(titles: [String]?
        , action: Selector, sender: AnyObject?,
          otherConfig items: [String: AnyObject]!) -> UIView
    optional func createAnima() -> CALayer
}

extension AbsViewFactoryDelegete {
    func create() -> UIViewController {
        return UIViewController()
    }
}

//extension AbsViewFactoryDelegete {
//    func createAnima() -> CALayer {
//        return CAShapeLayer()
//    }
//}

class AbsViewFactory: AbsViewFactoryDelegete {
    
    var viewFactory: AbsViewFactoryDelegete!
    
    @objc func createControl(titles: [String]?, action: Selector,
                       sender: AnyObject?, otherConfig items: [String:AnyObject]!) -> UIView {
            return viewFactory.createControl!(titles, action: action, sender: sender, otherConfig: items)
    }
    
    @objc func createAnima() -> CALayer {
        return viewFactory.createAnima!()
    }
    
    init (FactoryType aFactory: AbsViewFactoryDelegete) {
        self.viewFactory = aFactory
    }
    
    class func getDefaultFrame() -> CGRect {
        return CGRectMake(0, 0, 100, 30);
    }
}


class FactoryForLablePaddingOfSubDetail: AbsViewFactoryDelegete {
    @objc func createControl(titles: [String]?,action: Selector,
                       sender: AnyObject?, otherConfig items: [String:AnyObject]!) -> UIView {
            let label = UILabelPadding();
            label.frame = AbsViewFactory.getDefaultFrame();
            label.textAlignment = .Center;
            label.textColor = UIColor.lightGrayColor()
            //label.backgroundColor = UIColor.redColor()
            label.text = titles![0]
            label.lineBreakMode = .ByWordWrapping
            label.font = UIFont.systemFontOfSize(10)
            let size = UILabelPadding.getTxtSize(label.font, txt: label.text!)
            //size.width += 1
            //size.height += 1
            label.frame.size = size
            print(size)
            return label
    }
}

class FactoryForTextFiledOfLogin: AbsViewFactoryDelegete {
    @objc func createControl(titles: [String]?
        , action: Selector, sender: AnyObject?,
          otherConfig items: [String: AnyObject]!) -> UIView {
        let textFiled = TSUITextField(frame: AbsViewFactory.getDefaultFrame());
        textFiled.clearButtonMode = .WhileEditing
        textFiled.autocorrectionType = .No
        textFiled.autocapitalizationType = .None
        textFiled.placeholder = titles![0];
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        if let str = items["leftView"] as? String {
            textFiled.leftView = UIImageView(image: UIImage(named: str));
            textFiled.leftViewMode = .Always
        }
        
        if let color = items[TSUITextField.BottomLineColorOfNormal] as? UIColor {
            textFiled.setBottomLineColor(color, state: .Normal)
        }
        if let color = items[TSUITextField.BottomLineColorOfSelected] as? UIColor {
            textFiled.setBottomLineColor(color, state: .Selected)
        }
        
        return textFiled
    }
}

class FactoryForBtnOfNormal: AbsViewFactoryDelegete {
    @objc func createControl(titles: [String]?, action: Selector, sender: AnyObject?, otherConfig items: [String: AnyObject]!) -> UIView {
        let btn = UIButton(frame: AbsViewFactory.getDefaultFrame())
        btn.setTitle(titles![0], forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        btn.userInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        if let font = items["font"] as? UIFont {
            btn.titleLabel?.font = font
        }
        
        if let str = items["bgImg_Normal"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Normal)
        }
        if let str = items["bgImg_Clicked"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Highlighted)
        }
        if let str = items["bgImg_Disabled"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Disabled)
        }
        
        if (action != nil) {
            btn.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        }
        return btn;
    }

}

class FactoryForBtnOfBorder: AbsViewFactoryDelegete {
    @objc func createControl(titles: [String]?, action: Selector, sender: AnyObject?, otherConfig items: [String : AnyObject]!) -> UIView {
        let btn = UIButton(frame: AbsViewFactory.getDefaultFrame())
        btn.setTitle(titles![0], forState: .Normal)
        btn.setTitleColor(UIColor.orangeColorV1(), forState: .Normal)
        btn.backgroundColor = UIColor.clearColor()
        btn.layer.borderWidth = 1.2
        btn.layer.borderColor = UIColor.orangeColorV1().CGColor
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        
        if let font = items["font"] as? UIFont {
            btn.titleLabel?.font = font
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        if let str = items["bgImg_Normal"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Normal)
        }
        if let str = items["bgImg_Clicked"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Highlighted)
        }
        if let str = items["bgImg_Disabled"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Disabled)
        }
        
        if action != nil {
            btn.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}


//********************************************************

let g = 9.8 * 50
func degreer(d:CGFloat) -> CGFloat {
    return (d * Pi / 180)
}

class FactoryForAnimaOfCycle: AbsViewFactoryDelegete {
    @objc func createAnima() -> CALayer {
        let aLayer = self.createDD()
        
        let ani = CABasicAnimation(keyPath: "transform")
        var trans = CATransform3DIdentity
        //trans.m14 = -1/99
        trans = CATransform3DRotate(trans,Pi*3, 0, 0, 1)
        ani.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        ani.toValue = NSValue(CATransform3D: trans)//NSValue(CGPoint: CGPoint(x: 50, y: 50))
        //ani.autoreverses = true
        //ani.fillMode = kCAFillModeForwards
        //ani.removedOnCompletion = false
        ani.repeatCount = MAXFLOAT
        ani.duration = 2
        
        let aniKeys = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let distance:CGFloat = 100
        aniKeys.values = self.getValuesForFreefallD(2000, distance: distance)
        aniKeys.keyTimes = self.getTimesForFreefall(2000, distance: distance)
        aniKeys.repeatCount = MAXFLOAT
        aniKeys.duration = CFTimeInterval(self.getTimeForFreefall(distance))
        aniKeys.autoreverses = true
        
        //        let ani2 = CABasicAnimation(keyPath: "positon")
        //        ani2.fromValue = NSNumber
        let aniScale = CAKeyframeAnimation(keyPath: "transform")
        let transScale = CATransform3DMakeScale(1.2, 0.6, 1)
        
        aniScale.values = [NSValue(CATransform3D: CATransform3DIdentity),NSValue(CATransform3D: CATransform3DIdentity), NSValue(CATransform3D: transScale)]
        aniScale.keyTimes = [NSNumber(double: 0), NSNumber(double: 0.94), NSNumber(double: 1)];
        aniScale.repeatCount = MAXFLOAT
        aniScale.duration = CFTimeInterval(self.getTimeForFreefall(distance))
        aniScale.autoreverses = true
        
        let aniGrounp = CAAnimationGroup()
        aniGrounp.animations = [aniScale, aniKeys]
        aniGrounp.autoreverses = true
        aniGrounp.repeatCount = MAXFLOAT
        aniGrounp.duration = CFTimeInterval(self.getTimeForFreefall(distance))
        //aLayer.transform = trans
        //aLayer.addAnimation(ani, forKey: "anis")
        aLayer.addAnimation(aniGrounp, forKey: "aniKeys");
        
        return aLayer
    }
    
    func getValuesForFreefallD(divs: Int, distance: CGFloat) -> [AnyObject]? {
        var nsnumbers = [NSNumber]()
        let partTime = self.getTimeForFreefall(distance) / CGFloat(divs);
        nsnumbers.append(NSNumber(double: 0));
        var t = partTime;
        for _ in 0..<(divs-1) {
            let d = g.cgFloat*t*t / 2;
            nsnumbers.append(NSNumber(double: d.double))
            t += partTime;
        }
        nsnumbers.append(NSNumber(double: distance.double))
        //print(nsnumbers)
        return nsnumbers
    }
    
    func getTimeForFreefall(distance: CGFloat) -> CGFloat {
        return sqrt(2 * distance / g.cgFloat);
    }
    
    func getTimesForFreefall(divs: Int, distance: CGFloat) -> [NSNumber]
    {
        var nsnumbers = [NSNumber(double: 0)];
        let partTime = 1.0 / CGFloat(divs)
        var t = partTime;
        for _ in 0..<(divs - 1) {
            nsnumbers.append(NSNumber(double: t.double))
            t += partTime;
        }
        nsnumbers.append(NSNumber(double: 1))
        //print(nsnumbers)
        return nsnumbers
        
    }
    
    func createDD() -> CALayer {
        let aLayer = CAShapeLayer()
        aLayer.frame = CGRectMake(0, 0, 30, 30)
        aLayer.fillColor = UIColor.blueColor().CGColor
//        aLayer.position = self.view.center
        
        let path = UIBezierPath(ovalInRect: aLayer.bounds)
        aLayer.path = path.CGPath
        aLayer.anchorPoint.y = 1
        
        return aLayer
    }
}