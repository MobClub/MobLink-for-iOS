//
//  ViewController.swift
//  MobLinkDemo-Swift
//
//  Created by youzu on 2017/6/6.
//  Copyright © 2017年 mob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 路径
    var pathTextField : UITextField?
    // 来源
    var sourceTextField : UITextField?
    // 自定义参数
    var key1TextField : UITextField?
    var key2TextField : UITextField?
    var key3TextField : UITextField?
    var value1TextField : UITextField?
    var value2TextField : UITextField?
    var value3TextField : UITextField?
    // 分享按钮
    var shareBtn : UIButton?
    // mobid
    var currentMobId : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.setupUI()
        
    }
    
    /// 填充默认值
    func fillDefault()
    {
        self.pathTextField?.text = "/demo/a"
        self.sourceTextField?.text = "MobLinkDemo"
        self.key1TextField?.text = "key1"
        self.key2TextField?.text = "key2"
        self.key3TextField?.text = "key3"
        self.value1TextField?.text = "value1"
        self.value2TextField?.text = "value2"
        self.value3TextField?.text = "value3"
    }
    
    
    /// 界面初始化
    func setupUI() -> Void
    {
        let defaultBtn = UIButton(type: .roundedRect)
        defaultBtn.frame = CGRect(x: UIScreen.main.bounds.size.width - 100, y: 30, width: 80, height: 40)
        defaultBtn.setTitle("填充默认值", for: .normal)
        defaultBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        defaultBtn.setTitleColor(UIColor.blue, for: .normal)
        defaultBtn.backgroundColor = UIColor.lightGray
        defaultBtn.addTarget(self, action: #selector(fillDefault), for: .touchUpInside)
        view.addSubview(defaultBtn)
        
        let pathLabel = UILabel()
        pathLabel.text = "路径path"
        
        pathTextField = UITextField()
        pathTextField?.placeholder = "  仅/demo/a 或 /demo/b 有效"
        pathTextField?.layer.cornerRadius = 3.0
        pathTextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        pathTextField?.layer.borderWidth = 1
        
        let sourceLabel = UILabel()
        sourceLabel.text = "来源source"
        
        sourceTextField = UITextField()
        sourceTextField?.placeholder = "  用于记录来源,例如uuid-123456"
        sourceTextField?.layer.cornerRadius = 3.0
        sourceTextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        sourceTextField?.layer.borderWidth = 1
        
        let paramsLabel = UILabel()
        paramsLabel.text = "自定义参数"
        
        key1TextField = UITextField()
        key1TextField?.placeholder = "  键key"
        key1TextField?.layer.cornerRadius = 3.0
        key1TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        key1TextField?.layer.borderWidth = 1
        
        key2TextField = UITextField()
        key2TextField?.placeholder = "  键key"
        key2TextField?.layer.cornerRadius = 3.0
        key2TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        key2TextField?.layer.borderWidth = 1
        
        key3TextField = UITextField()
        key3TextField?.placeholder = "  键key"
        key3TextField?.layer.cornerRadius = 3.0
        key3TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        key3TextField?.layer.borderWidth = 1
        
        value1TextField = UITextField()
        value1TextField?.placeholder = "  值value"
        value1TextField?.layer.cornerRadius = 3.0
        value1TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        value1TextField?.layer.borderWidth = 1
        
        value2TextField = UITextField()
        value2TextField?.placeholder = "  值value"
        value2TextField?.layer.cornerRadius = 3.0
        value2TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        value2TextField?.layer.borderWidth = 1
        
        value3TextField = UITextField()
        value3TextField?.placeholder = "  值value"
        value3TextField?.layer.cornerRadius = 3.0
        value3TextField?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        value3TextField?.layer.borderWidth = 1
        
        let getMobIdBtn = UIButton()
        getMobIdBtn.setTitle("获取MobId", for:.normal)
        getMobIdBtn.setTitleColor(MOBFColor.color(withRGB:0x4e8bed), for: .normal)
        getMobIdBtn.addTarget(self, action: #selector(getMobId), for:.touchUpInside)
        getMobIdBtn.layer.cornerRadius = 3.0
        getMobIdBtn.layer.borderColor = MOBFColor.color(withRGB:0x4e8bed).cgColor
        getMobIdBtn.layer.borderWidth = 1
        
        shareBtn = UIButton()
        
        shareBtn?.setTitle("分享", for:.normal)
        shareBtn?.setTitleColor(MOBFColor.color(withRGB:0xa4a4a4), for:.normal)
        shareBtn?.addTarget(self, action: #selector(share), for:.touchUpInside)
        shareBtn?.layer.cornerRadius = 3.0
        shareBtn?.layer.borderWidth = 1
        shareBtn?.layer.borderColor = MOBFColor.color(withRGB:0xe3e3e3).cgColor
        
        self.view.addSubview(pathLabel)
        self.view.addSubview(sourceLabel)
        self.view.addSubview(paramsLabel)
        self.view.addSubview(pathTextField!)
        self.view.addSubview(sourceTextField!)
        self.view.addSubview(key1TextField!)
        self.view.addSubview(key2TextField!)
        self.view.addSubview(key3TextField!)
        self.view.addSubview(value1TextField!)
        self.view.addSubview(value2TextField!)
        self.view.addSubview(value3TextField!)
        self.view.addSubview(getMobIdBtn)
        self.view.addSubview(shareBtn!)
        
        pathLabel.translatesAutoresizingMaskIntoConstraints = false
        pathTextField?.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceTextField?.translatesAutoresizingMaskIntoConstraints = false
        paramsLabel.translatesAutoresizingMaskIntoConstraints = false
        key1TextField?.translatesAutoresizingMaskIntoConstraints = false
        key2TextField?.translatesAutoresizingMaskIntoConstraints = false
        key3TextField?.translatesAutoresizingMaskIntoConstraints = false
        value1TextField?.translatesAutoresizingMaskIntoConstraints = false
        value2TextField?.translatesAutoresizingMaskIntoConstraints = false
        value3TextField?.translatesAutoresizingMaskIntoConstraints = false
        getMobIdBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn?.translatesAutoresizingMaskIntoConstraints = false
        
        let screenHeight = self.view.frame.size.height
        let screenWidth = self.view.frame.size.width
        
        //垂直方向
        let labelHeight = 0.022 * screenHeight
        let textFieldHeight = 0.059 * screenHeight
        let longSpace = 0.037 * screenHeight
        let shortSpace = 0.015 * screenHeight
        let btnUpSpace = 0.067 * screenHeight
        let btnSpace = 0.029 * screenHeight
        let btnHeight = 0.060 * screenHeight
        let upSpace = 64 + longSpace
        
        //水平方向
        let horizSpace = 0.027 * screenWidth
        let keyWidth = 0.4 * screenWidth
        
        
        let pathLabelVFL = "H:|-horizSpace-[pathLabel(100)]"
        let pathLabelConstraint = NSLayoutConstraint.constraints(withVisualFormat: pathLabelVFL, options:.alignAllTop, metrics:["horizSpace" : horizSpace], views: ["pathLabel" : pathLabel])
        
        let pathTextFieldVFL = "H:|-horizSpace-[pathTextField]-horizSpace-|"
        let pathTextFieldConstraint = NSLayoutConstraint.constraints(withVisualFormat: pathTextFieldVFL, options: .alignAllTop, metrics: ["horizSpace" : horizSpace], views: ["pathTextField" : pathTextField!])
        
        let sourceTextFieldVFL = "H:|-horizSpace-[sourceTextField]-horizSpace-|"
        let sourceTextFieldConstraint = NSLayoutConstraint.constraints(withVisualFormat: sourceTextFieldVFL, options: .alignAllTop, metrics: ["horizSpace" : horizSpace], views: ["sourceTextField" : sourceTextField!])
        
        
        let kv1TestFieldVFL = "H:|-horizSpace-[key1TextField(keyWidth)]-horizSpace-[value1TextField]-horizSpace-|"
        let kv1TestFieldConstraint = NSLayoutConstraint.constraints(withVisualFormat: kv1TestFieldVFL, options: .alignAllLastBaseline, metrics: ["horizSpace" : horizSpace, "keyWidth" : keyWidth], views: ["key1TextField" : key1TextField!,"value1TextField":value1TextField!])
        
        let kv2TestFieldVFL = "H:|-horizSpace-[key2TextField(keyWidth)]-horizSpace-[value2TextField]-horizSpace-|"
        let kv2TestFieldConstraint = NSLayoutConstraint.constraints(withVisualFormat: kv2TestFieldVFL, options: .alignAllLastBaseline, metrics: ["horizSpace" : horizSpace, "keyWidth" : keyWidth], views: ["key2TextField" : key2TextField!,"value2TextField":value2TextField!])
        
        let kv3TestFieldVFL = "H:|-horizSpace-[key3TextField(keyWidth)]-horizSpace-[value3TextField]-horizSpace-|"
        let kv3TestFieldConstraint = NSLayoutConstraint.constraints(withVisualFormat: kv3TestFieldVFL, options: .alignAllLastBaseline, metrics: ["horizSpace" : horizSpace, "keyWidth" : keyWidth], views: ["key3TextField" : key3TextField!,"value3TextField":value3TextField!])
        
        let verticalViews:[String:AnyObject] = ["pathLabel": pathLabel,
                                                "pathTextField": pathTextField!,
                                                "sourceLabel": sourceLabel,
                                                "sourceTextField" : sourceTextField!,
                                                "paramsLabel" : paramsLabel,
                                                "key1TextField" : key1TextField!,
                                                "key2TextField" : key2TextField!,
                                                "key3TextField" : key3TextField!,
                                                "getMobIdBtn" : getMobIdBtn,
                                                "shareBtn" : shareBtn!]
        
        let verticalMetrics = ["labelHeight" : labelHeight,
                               "textFieldHeight" : textFieldHeight,
                               "longSpace" : longSpace,
                               "shortSpace" : shortSpace,
                               "btnUpSpace" : btnUpSpace,
                               "btnSpace" : btnSpace,
                               "upSpace" : upSpace,
                               "btnHeight" : btnHeight]
        
        
        let verticalViewVFL = "V:|-upSpace-[pathLabel(labelHeight)]-shortSpace-[pathTextField(textFieldHeight)]-longSpace-[sourceLabel(labelHeight)]-shortSpace-[sourceTextField(textFieldHeight)]-longSpace-[paramsLabel(labelHeight)]-shortSpace-[key1TextField(textFieldHeight)]-shortSpace-[key2TextField(textFieldHeight)]-shortSpace-[key3TextField(textFieldHeight)]-btnUpSpace-[getMobIdBtn(btnHeight)]-btnSpace-[shareBtn(btnHeight)]-(>=55)-|"
        
        
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: verticalViewVFL, options:.alignAllLeft, metrics: verticalMetrics, views: verticalViews)
        
        let getMobIdBtnVFL = "H:|-horizSpace-[getMobIdBtn]-horizSpace-|"
        let getMobIdBtnConstraint = NSLayoutConstraint.constraints(withVisualFormat: getMobIdBtnVFL, options: .alignAllTop, metrics: ["horizSpace" : horizSpace], views: ["getMobIdBtn" : getMobIdBtn])
        let shareBtnBtnVFL = "H:|-horizSpace-[shareBtn]-horizSpace-|"
        let shareBtnConstraint = NSLayoutConstraint.constraints(withVisualFormat: shareBtnBtnVFL, options: .alignAllTop, metrics: ["horizSpace" : horizSpace], views: ["shareBtn" : shareBtn!])
        
        self.view.addConstraint(NSLayoutConstraint.init(item: key1TextField!, attribute:.height, relatedBy: .equal, toItem: value1TextField, attribute: .height, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: key2TextField!, attribute:.height, relatedBy: .equal, toItem: value2TextField, attribute: .height, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: key3TextField!, attribute:.height, relatedBy: .equal, toItem: value3TextField, attribute: .height, multiplier: 1, constant: 0))
        
        self.view.addConstraints(pathLabelConstraint)
        self.view.addConstraints(pathTextFieldConstraint)
        self.view.addConstraints(kv1TestFieldConstraint + kv2TestFieldConstraint + kv3TestFieldConstraint)
        self.view.addConstraints(sourceTextFieldConstraint)
        self.view.addConstraints(verticalConstraint)
        self.view.addConstraints(getMobIdBtnConstraint + shareBtnConstraint)
        
    }
    
    /// 获取mobid
    func getMobId(){
        
        // 校验路径正确性
        let path = self.pathTextField?.text ?? ""
        if path != "/demo/a"  && path != "/demo/b" {
            let alert : UIAlertView = UIAlertView(title: "提示", message: "路径填写错误！请填写\"/demo/a\" 或\"/demo/b\"" , delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return;
        }
        
        // 构造自定义参数字典
        var customParams: [String: Any] = [String: Any]()
        let key1 = self.key1TextField?.text ?? ""
        let val1 = self.value1TextField?.text ?? ""
        let key2 = self.key2TextField?.text ?? ""
        let val2 = self.value2TextField?.text ?? ""
        let key3 = self.key3TextField?.text ?? ""
        let val3 = self.value3TextField?.text ?? ""
        
        if key1.lengthOfBytes(using: String.Encoding.utf8) > 0 && val1.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            customParams[key1] = val1
        }
        if key2.lengthOfBytes(using: String.Encoding.utf8) > 0 && val2.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            customParams[key2] = val2
        }
        if key3.lengthOfBytes(using: String.Encoding.utf8) > 0 && val3.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            customParams[key3] = val3
        }
        
        // 生成scene用于获取mobid
        let source = self.sourceTextField?.text ?? ""
        let scene: MLSDKScene = MLSDKScene.init(mlsdkPath: path, source: source, params: customParams)
        
        MobLink.getMobId(scene) { [unowned self] (mobidStr: String?) in
            if let mobid = mobidStr {
                // 记录获取到的mobid
                self.currentMobId = mobid
                
                self.shareBtn?.setTitleColor(MOBFColor.color(withRGB: 0x4e8bed), for: .normal)
                self.shareBtn?.layer.borderColor = MOBFColor.color(withRGB: 0x4e8bed).cgColor
                
                let alert : UIAlertView = UIAlertView(title: "提示", message: "MobId获取成功！" , delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            else
            {
                self.shareBtn?.setTitleColor(MOBFColor.color(withRGB: 0xa4a4a4), for: .normal)
                self.shareBtn?.layer.borderColor = MOBFColor.color(withRGB: 0xe3e3e3).cgColor
                
                let alert : UIAlertView = UIAlertView(title: "提示", message: "MobId获取失败！" , delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
    }
    
    
    /// 分享
    func share(){
        
        guard let mobid = self.currentMobId else {
            let alert : UIAlertView = UIAlertView(title: "提示", message: "请先获取MobId！" , delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return;
        }
        
        let shareParams: NSMutableDictionary = NSMutableDictionary()
        let urlStr = "http://f.moblink.mob.com" + (self.pathTextField?.text)! + "?mobid=\(mobid)"
        let shareURL = URL(string: urlStr)
        let shareImage = UIImage(named: "moblink_wxtj.png")
        
        shareParams.ssdkSetupShareParams(byText: "这是一个MobLink演示", images: shareImage, url: shareURL, title: "MobLink帮你实现网页APP相互跳转", type: SSDKContentType.webPage)
        
        SSUIShareActionSheetStyle.setShareActionSheetStyle(ShareActionSheetStyle.simple)
        
        ShareSDK.showShareActionSheet(self.shareBtn, items: [SSDKPlatformType.typeSinaWeibo.rawValue, SSDKPlatformType.typeQQ.rawValue, SSDKPlatformType.subTypeWechatSession.rawValue, SSDKPlatformType.subTypeWechatTimeline.rawValue], shareParams: shareParams) { (state:SSDKResponseState, platform:SSDKPlatformType, _, _, _, _) in
            
            switch state
            {
            case SSDKResponseState.success:
                print("分享成功！")
            case SSDKResponseState.fail:
                print("分享失败！")
            default:
                break
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        pathTextField?.resignFirstResponder()
        sourceTextField?.resignFirstResponder()
        key1TextField?.resignFirstResponder()
        key2TextField?.resignFirstResponder()
        key3TextField?.resignFirstResponder()
        value1TextField?.resignFirstResponder()
        value2TextField?.resignFirstResponder()
        value3TextField?.resignFirstResponder()
    }
    
}

