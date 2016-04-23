//
//  GRNetwork.swift
//  TestApp
//
//  Created by caizhili on 16/4/18.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum Router: URLRequestConvertible {
    static let baseURLString = "http://localhost/ios/TServices"
    
    case QueryUserIsExist(UserInfo)
    case QueryUser(UserInfo)
    case RegUser(UserInfo)
    case GetUser(UserInfo)
    case GetAllCourse
    case GetQtypes(Course)
    
    var method: Alamofire.Method {
        switch self {
        case .QueryUserIsExist(_):
            return .POST
        case .QueryUser(_):
            return .POST
        case .RegUser(_):
            return .POST
        case .GetUser(_):
            return .GET
        case .GetAllCourse:
            return .GET
        case .GetQtypes(_):
            return .GET
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let (path, parameters) = {
            ()->(String, [String: AnyObject]) in
            switch self {
            case .QueryUserIsExist(let user):
                let params = ["user": user.userName]
                return ("/queryUser.php", params)
            case .QueryUser(let user):
                let params = ["user": user.userName,
                              "pwd": user.pwd,
                              "uuid": UIDevice.currentDevice().identifierForVendor!.UUIDString]
                return ("/login.php",params)
            case .RegUser(let user):
                let params = ["user": user.userName,
                              "pwd": user.pwd]
                return ("/reg.php", params)
            case .GetUser(let user):
                let params = ["user": user.userName]
                return ("/getUser.php", params)
            case .GetAllCourse:
                let parames = [String: AnyObject]();
                return ("/getCourses.php", parames)
            case .GetQtypes(let course):
                let parames = ["c_No": course.c_No]
                return ("/getQtypesByCourse.php", parames)
            }
        }()
        
        let url = NSURL(string: Router.baseURLString)
        let urlRequest = NSMutableURLRequest(URL: url!.URLByAppendingPathComponent(path))
        urlRequest.HTTPMethod = self.method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(urlRequest, parameters: parameters).0
    }
}


@objc
protocol GRNetworkDelegateForUserInfo {
    optional func checkoutUserInfoFinished(ok: Bool);
    optional func checkoutUserInfoFail(fail: Bool);
    
    optional func queryUserIsExists(exists: Bool);
    optional func queryUserIsExistsFail(fail: Bool);
    
    optional func regUserFinished(ok: Bool);
    optional func regUserFail(fail: Bool);
}

@objc
protocol GRNetworkDelegateForCourse {
    func getAllCoursesFinished(courses: [Course]);
    func getAllCoursesFail(fail: Bool);
}

@objc
protocol GRNetworkDelegateForQtype {
    func getQtypeFinished(qtypes: [String: AnyObject])
    func getQtypeFail(fail: Bool)
}

class GRNetwork: NSObject {
    
    var delegateForUserInfo: GRNetworkDelegateForUserInfo!
    var delegateForCourse: GRNetworkDelegateForCourse!
    var delegateForQtype: GRNetworkDelegateForQtype!
    //URLRequestConvertible
    //单例模式
    class var shareInstance: GRNetwork {
        struct Static {
            static var instance: GRNetwork?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) { 
            Static.instance = GRNetwork()
        }
        
        return Static.instance!
    }
    
}

extension GRNetwork {
    func checkoutUserInfo(user: UserInfo) {
        Alamofire.request(Router.QueryUser(user)).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(data: response.data!);
                let ok = json["status"].int
                print(json)
                if ok != nil {
                    print(ok!)
                    self.delegateForUserInfo.checkoutUserInfoFinished!(ok! == 1);
                } else {
                    self.delegateForUserInfo.checkoutUserInfoFinished!(false);
                }
            } else {
                self.delegateForUserInfo.checkoutUserInfoFail!(true)
            }
        }
    }
    
    func queryUser(user: UserInfo) {
        Alamofire.request(Router.QueryUserIsExist(user)).responseJSON { (res) in
            if res.result.isSuccess {
                let json = JSON(data: res.data!)
                self.delegateForUserInfo.queryUserIsExists!(json["status"].int == 1)
            } else {
                self.delegateForUserInfo.queryUserIsExistsFail!(true)
            }
        }
    }
    
    func regUser(user: UserInfo) {
        Alamofire.request(Router.RegUser(user)).responseJSON { (res) in
            if res.result.isSuccess {
                let json = JSON(data: res.data!)
                self.delegateForUserInfo.regUserFinished!(json["reg"]["reg_status"].int == 1)
            } else {
                self.delegateForUserInfo.regUserFail!(true)
            }
        }
    }
}

extension GRNetwork {

    func getAllCourses() {
        Alamofire.request(Router.GetAllCourse).responseJSON { (res) in
            if res.result.isSuccess {
                let json = JSON(data: res.data!)
                print(json)
                var courses = [Course]()
                if json["count"].int != 0 {
                    for item in json["course"].array! {
                        let aCourse = Course(dict: item.dictionaryObject!)
                        courses.append(aCourse)
                    }
                }
                self.delegateForCourse.getAllCoursesFinished(courses)
            } else {
                self.delegateForCourse.getAllCoursesFail(false)
            }
        }
    }
}

extension GRNetwork {
    func getQtypesByCourse(course: Course) {
        Alamofire.request(Router.GetQtypes(course)).responseJSON { (res) in
            if res.result.isSuccess {
                let json = JSON(data: res.data!)
                print("abc\(json)")
                var dict = [String: [Qtype]]()
                for item in json["qtypes"].array! {
                    let aQtype = Qtype(dict: item.dictionaryObject!)
                    if dict[aQtype.qtt_NameCn] == nil {
                        dict[aQtype.qtt_NameCn] = [aQtype]
                    } else {
                        dict[aQtype.qtt_NameCn]?.append(aQtype)
                    }
                }
                print(dict)
                self.delegateForQtype.getQtypeFinished(dict)
            } else {
                self.delegateForQtype.getQtypeFail(true)
            }
        }
    }
}
