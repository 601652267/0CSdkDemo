//
//  LoginViewController.swift
//  anXingBaoSDK
//
//  Created by 朱海铭 on 2018/4/15.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

import UIKit



public class LoginViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100));
        button.backgroundColor = .red;
        self.view.addSubview(button);
        button.setBackgroundImage(bundleTool.share().initImage(name: "Loca"), for: .normal);
        button.addTarget(self, action: #selector(login), for: .touchUpInside);

        // Do any additional setup after loading the view.
    }
    
    class func setAppLanguage() {
        let languages = NSLocale.preferredLanguages;
        let language = languages.first;
        if language == "zh-Hans" || language == "zh-Hans-CN" {
            UserDefaults.standard.set("zh-Hans", forKey: "appLanguage");
        } else if language == "zh-Hant" || language == "zh-HK" || language == "zh-MO" || language == "zh-TW" || language == "zh-SG" || language == "zh-Hant-HK" || language == "zh-Hant-MO" || language == "zh-Hant-TW" {
            UserDefaults.standard.set("zh-Hant", forKey: "appLanguage");
        } else  {
            UserDefaults.standard.set("zh-Hans", forKey: "appLanguage");
        }
        UserDefaults.standard.synchronize();
    }
    
    func login() {
        LoginViewController.setAppLanguage();
//        loginTool.login(username: "", pass: "", successBlock: {
//            self.PushDevice(animation: true);
//        }) { (msg, detail) in
//            print("msg == \(msg, detail)")
//        }
    }
    
    class func login(username:String, pass:String, controller:UIViewController, faild faildBlock:@escaping (String, String) -> Void, successBlock:@escaping () -> Void) {
        loginTool.login(username: username, pass: pass, successBlock: {
            
        }) { (msg, detail) in
        }
    }
    
    
    /* 进入设备主页面 */
    func PushDevice(animation:Bool) {
        let device = DeviceListViewController.init(nibName: "DeviceListViewController", bundle: bundleTool.share().returnXibBundle());
        device.titleName = "";
        let navc = BaseNavigationController.init(rootViewController: device);
        present(navc, animated: true, completion: nil);
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
