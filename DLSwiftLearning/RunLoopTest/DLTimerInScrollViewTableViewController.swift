//
//  DLTimerInScrollViewTableViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 20/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  这里主要解决定时器在scrollView里面如果滚动scrollView无法使用的问题
//  参考链接：http://blog.csdn.net/u011619283/article/details/53436907

import UIKit

class DLTimerInScrollViewTableViewController: UITableViewController{
    @IBOutlet weak var collectionView: UICollectionView! //广告轮播图
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var timerLabelTwo: UILabel!
    
    
    var count: Int = 0
    var countTwo: Int = 0
    
    /*
     然后，我们在滑动tableView的时候timerUpdate方法，并不会调用。
     * 原因是啥呢？*
     原因是当我们滑动scrollView时，主线程的RunLoop 会切换到UITrackingRunLoopMode这个Mode，执行的也是UITrackingRunLoopMode下的任务（Mode中的item），而timer 是添加在NSDefaultRunLoopMode下的，所以timer任务并不会执行，只有当UITrackingRunLoopMode的任务执行完毕，runloop切换到NSDefaultRunLoopMode后，才会继续执行timer。
     
     * 要如何解决这一问题呢？*
     解决方法很简单，我们只需要在添加timer 时，将mode 设置为NSRunLoopCommonModes即可。
     */
    lazy var timer: Timer = {
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes) //关键
        return timer
    }()
    
    
    //第二种方式  加入到子线程中，但是要注意如果是在子线程中运行timer,那么将timer添加到RunLoop中后，Mode设置为NSDefaultRunLoopMode或NSRunLoopCommonModes均可，但是需要保证RunLoop在运行，且其中有任务。
    lazy var timerTwo: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdateTow), userInfo: nil, repeats: true)
        return timer
    }()
    
    lazy var subThread:Thread = {//将定时器放在子线程中
        let thread = Thread(target: self, selector: #selector(timerTestOfSubThread), object: nil)
        return thread
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////GCD定时器操作//////////////
        DispatchAfter(after: 5) {
            print("延时操作")
        }
        
        DispatchTimer(timeInterval: 1) { (timer) in
            print("你好")
        }
        
        DispatchTimer(timerInterval: 1, repeatCount: -1) { (timer, count) in
            print("剩余执行次数 = \(count)")
        }
        //////GCD定时器操作//////////////
        
        
        
        self.timerTest() //1.第一种加入commmodes方式
        self.subThread.start()  //2.第二种开辟子线程方式
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //此代码作用：让tableview的HeaderView高度自适应
        //利用systemLayoutSizeFittingSize:计算出真实高度
        
        /*  //这里屏蔽的原因是：计算出来的高度为0，需要再调试
        let height = self.tableView.tableHeaderView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        var headerFrame = self.tableView.tableHeaderView?.frame;
        headerFrame?.size.height = height!
        //修改header的frame
        self.tableView.tableHeaderView?.frame = headerFrame!
 */
    }
    
    func timerTest() {
        self.timer.fire()
    }
    
    //第二种启动定时器的方法
    @objc func timerTestOfSubThread() {
        autoreleasepool { () -> () in
            let runLoop = RunLoop.current
            print("启动runLoop前——\(String(describing: runLoop.currentMode))")
            print("currentRunLoop:\(RunLoop.current)")
            self.timerTwo.fire()
            RunLoop.current.run()  //如果不启动runloop，就无法长时间keep子线程，定时器只走一次就结束了
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func timerUpdate() {
        print("当前线程：\(Thread.current)")
        print("启动RunLoop后——\(String(describing: RunLoop.current.currentMode))")
        
        DispatchQueue.main.async {
            self.count += 1
            self.countDownLabel.text = "计时器：\(self.count)"
        }
        
    }
    
    @objc func timerUpdateTow(){
        print("当前线程：\(Thread.current)")
        print("启动RunLoop后——\(String(describing: RunLoop.current.currentMode))")
        print("currentRunLoop:\(RunLoop.current)")
        
        DispatchQueue.main.async {
            self.countTwo += 1
            self.timerLabelTwo.text = "计时器：\(self.countTwo)"
        }
    }
}
