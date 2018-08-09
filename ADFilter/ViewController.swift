//
//  ViewController.swift
//  ADFilter
//
//  Created by 李刚 on 2018/8/9.
//  Copyright © 2018年 sunsheen. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController {
//    lazy var secureAppGroupPersistentStoreURL : URL = {
//        let fileManager = FileManager.default
//        let groupDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.sunsheen.noad")!
//        return groupDirectory.appendingPathComponent("blockerList.json")
//    }()
    
    @IBOutlet weak var dis_state: UILabel!
    var blockerState:String? {
        set {
            DispatchQueue.main.async {
                self.dis_state.text = newValue
            }
        }
        get {
            return nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        getBlockerState()
    }
    
    @IBAction func refreshState(_ sender: Any) {
        getBlockerState()
    }
    
    @IBAction func reloadBlocker(_ sender: Any) {
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: "org.dev.ADFilter.blocker") { error in
            if let error = error {
                let alert = UIAlertController(title: "提示", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else {
                let alert = UIAlertController(title: "提示", message: "重新加载成功！", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: {
                    alert.dismiss(animated: false, completion: nil)
                })
            }
        }
    }
    
    func getBlockerState(){
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: "org.dev.ADFilter.blocker") { (sfbs, error) in
            if let error = error {
                let alert = UIAlertController(title: "提示", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else {
                if let isUse = sfbs?.isEnabled,isUse {
                    self.blockerState = "扩展已启用"
                    
                }else {
                    self.blockerState = "扩展未启用"
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

