//
//  DemoRestoreBViewController.swift
//  MobLinkDemo-Swift
//
//  Created by youzu on 2017/6/7.
//  Copyright © 2017年 mob. All rights reserved.
//

import UIKit

class DemoRestoreBViewController: UIViewController {
    
    // 场景
    var scene: MLSDKScene?
    
    // 控制器路径
    override class func mlsdkPath() -> String {
        // 该控制器的特殊路径
        return "/demo/b"
    }
    
    
    // 根据场景信息初始化方法
    convenience init!(mobLinkScene scene: MLSDKScene!) {
        self.init()
        
        //记录返回的场景参数信息
        self.scene = scene
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = "B"
        
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        label.center = view.center
        label.text = "B"
        label.font = UIFont.systemFont(ofSize: 188)
        label.textAlignment = .center
        view.addSubview(label)
        
        print(scene?.path ?? "")
        print(scene?.source ?? "")
        print(scene?.params ?? [])
        
        let dismissBtn = UIButton(type: .custom)
        dismissBtn.frame = CGRect(x: 20, y: 30, width: 60, height: 30)
        dismissBtn.setTitle("关闭", for: .normal)
        dismissBtn.setTitleColor(UIColor.black, for: .normal)
        dismissBtn.backgroundColor = UIColor.lightGray
        dismissBtn.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        view.addSubview(dismissBtn)
    }
    
    
    func dismissBtnClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
