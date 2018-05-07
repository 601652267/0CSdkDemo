    //
//  AXBSDK.swift
//  anXingBaoSDK
//
//  Created by 朱海铭 on 2018/4/17.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

import UIKit

public class AXBSDK: NSObject {

    var controller:UIViewController? = nil; // 进入设备列表的控制器
    public var loginSuccess:(()->Void)? = nil; // 登录成功
    public var loginFaild:((String, String)->Void)? = nil; // 登录失败
    public var tokenFaild:(()->Void)? = nil; // token验证失效
    public var deviceListBlock:((UIViewController)->Void)? = nil; // 返回设备列表的controller 可以将其嵌套到自己自定义的controller
    public var deviceBindBlock:(()->Void)? = nil; // 可以绑定设备的回调
    public var deviceBindOverBlock:(()->Void)? = nil; // 绑定设备数量过多的回调
    public var deviceLocationBlock:((NSMutableDictionary)->Void)? = nil; // 设备定位信息

    public override init() {
        super.init();
        NotificationCenter.default.addObserver(self, selector: #selector(AXBTokenError), name: NSNotification.Name(rawValue: tokenError), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(checkShouldBind), name: NSNotification.Name(rawValue: refreshDeviceList), object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(getLocation), name: NSNotification.Name(rawValue: "LOCATIONMSG"), object: nil);
    }
    
    func checkShouldBind() {
        FMDBHelp.share().getUserListIMEI { (arr) in
            if arr.count > 0 {
                if self.deviceBindOverBlock != nil {
                    self.deviceBindOverBlock!();
                }
            } else {
                if self.deviceBindBlock != nil {
                    self.deviceBindBlock!();
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: tokenError), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: refreshDeviceList), object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "LOCATIONMSG"), object: nil);
        controller = nil;
        loginFaild = nil;
        loginSuccess = nil;
        tokenFaild = nil;
    }
    
    func getLocation(notica:Notification) {
        if let arr = notica.object as? NSMutableArray, arr.count > 0 , self.deviceLocationBlock != nil {
            for data in arr {
                if let dic = data as? NSMutableDictionary {
                    self.deviceLocationBlock!(dic);
                }
            }
        }
    }
    
    //MARK:-
    // MARK:验证key
    public func apiKey(key:String, amapKey:String) {
        loginTool.init().checkKey(key: key, amapKey: amapKey);
    }
    //MARK:-
    
    //MARK:-
    // MARK:验证key
    public func bindDevice(controller:UIViewController) {
        if UserManager.share().isLogin == false {
            print("请先登录")
            return;
        }
        FMDBHelp.share().getUserListIMEI { (arr) in
            if arr.count > 0 {
                print("绑定数量超过一台");
                if self.deviceBindOverBlock != nil {
                    self.deviceBindOverBlock!();
                }
                return;
            }
        }
        let bind = AddNewDeviceViewController.init(nibName: "", bundle: bundleTool.share().returnXibBundle());
        let navc = UINavigationController.init(rootViewController: bind);
        controller.present(navc, animated: true, completion: nil);
    }
    //MARK:-

    //MARK:-
    // MARK:token失效
    @objc func AXBTokenError() {
        if tokenFaild != nil {
            tokenFaild!();
        }
    }
    //MARK:-
    
    //MARK:-
    // MARK:退出登录
    public func loginOut() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: loginOutTopic), object: nil);
    }

    //MARK:-
    
    //MARK:-
    //MARK:登录
    public func login(username:String, pass:String, faild faildBlock:@escaping (String, String) -> Void, successBlock:@escaping () -> Void) {
        loginTool.login(username: username, pass: pass, successBlock: {
            self.successLogin();
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: frameworkLoad), object: nil);
        }) { (msg, detail) in
            self.faildLogin(msg: msg, detail: detail);
        }
    }
    
    // 登录调用接口 直接进入设备列表controller
    public func login(username:String, pass:String, controller:UIViewController, faild faildBlock:@escaping (String, String) -> Void, successBlock:@escaping () -> Void) {
        self.controller = controller;
        UserManager.share().getUserInfo(notOnline: {
            loginTool.login(username: username, pass: pass, successBlock: {
                self.successLogin();
            }) { (msg, detail) in
                self.faildLogin(msg: msg, detail: detail);
            }
        }, login: {
            UserManager.share().style = .withOutLogin;
            self.successLogin();
        });
        self.PushDevice(controller: controller);
    }
    // 成功登录
    func successLogin() {
        if loginSuccess != nil {
            loginSuccess!();
        }
        checkShouldBind();
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: frameworkLoad), object: nil);
    }
    
    // 登录失败
    func faildLogin(msg:String, detail:String) {
        if loginFaild != nil {
            loginFaild!(msg, detail);
        }
    }
    //MARK:-
 
    
    /* 进入设备主页面 */
    func PushDevice(controller:UIViewController) {
        setAppLanguage();
        let device = DeviceListViewController.init(nibName: "DeviceListViewController", bundle: bundleTool.share().returnXibBundle());
        device.titleName = "";
        let navc = BaseNavigationController.init(rootViewController: device);
        if deviceListBlock != nil {
            weak var weakSuper = controller;
            device.superController = {
                return weakSuper;
            }
            deviceListBlock!(navc);
        } else {
            controller.present(navc, animated: true, completion: nil);
        }
    }
    
    func setAppLanguage() {
        let languages = NSLocale.preferredLanguages;
        let language = languages.first;
        if language == "zh-Hans" || language == "zh-Hans-CN" {
            UserDefaults.standard.set("zh-Hans", forKey: "appLanguage");
        } else if language == "zh-Hant" || language == "zh-HK" || language == "zh-MO" || language == "zh-TW" || language == "zh-SG" || language == "zh-Hant-HK" || language == "zh-Hant-MO" || language == "zh-Hant-TW" {
            UserDefaults.standard.set("zh-Hant", forKey: "appLanguage");
        } else  {
            UserDefaults.standard.set("zh-Hans", forKey: "appLanguage");
        }
    }
    
    public func sendmsg(msg:String) {
        let alertData = NSMutableDictionary();
        alertData.setValue(NSMutableDictionary.init(object: msg, forKey: "alert" as NSCopying), forKey: "aps")
        EBForeNotification.handleRemoteNotification(alertData as! [AnyHashable : Any], soundID: 1312, isIos10: false);
    }
    
}
