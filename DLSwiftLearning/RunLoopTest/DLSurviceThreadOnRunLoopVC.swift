//
//  DLSurviceThreadOnRunLoopVC.swift
//  DLSwiftLearning
//
//  Created by denglong on 19/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  runloop作用：存活线程
//  参考地址：http://blog.csdn.net/u011619283/article/details/53433243

import UIKit

class DLSurviceThreadOnRunLoopVC: ViewController {

    //懒加载
    lazy var subThread: HLThread = {
        let thread = HLThread(target: self, selector: #selector(subThreadEntryPoint), object: nil)
        thread.name = "HLThread"
        return thread
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        threadTest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func threadTest() {
        subThread.start()
    }
    
    //@objc作用：赋予其 Objective-C 的 runtime（运行时）
    @objc func subThreadOpetion() {
        autoreleasepool { () -> () in
            
            print("启动RunLoop后——\(String(describing: RunLoop.current.currentMode))")
            print("\(Thread.current)----子线程任务开始")
            Thread.sleep(forTimeInterval: 3.0)
            print("\(Thread.current)----子线程任务结束")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //将任务扔到runloop上
        self.perform(#selector(subThreadOpetion), on: self.subThread, with: nil, waitUntilDone: false)
    }
    
    
    //子线程启动后，启动runloop
    @objc func subThreadEntryPoint() {
        autoreleasepool { () -> () in
            let runLoop = RunLoop.current
            runLoop.add(NSMachPort(), forMode: RunLoopMode.commonModes)
            print("启动RunLoop前:\(String(describing: runLoop.currentMode))")
            runLoop.run()
        }
    }

}
