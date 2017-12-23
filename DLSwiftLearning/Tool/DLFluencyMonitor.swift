//
//  DLFluencyMonitor.swift
//  DLSwiftLearning
//
//  Created by denglong on 23/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class DLFluencyMonitor: NSObject {
    /**< 监控线程 */
    lazy private var monitorThread:Thread? = {
        let subThread:Thread = Thread(target: self, selector: #selector(monitorThreadEntryPoint), object: nil)
        return subThread
    }()
    private var observer:CFRunLoopObserver?/**< 观察者 */
    private var timer:CFRunLoopTimer?/**< 定时器 */
    
    private var startDate:NSDate?/**< 开始执行的时间 */
    private var excuting:Bool?/**< 是否还在执行 */
    
    private var interval:TimeInterval?/**< 定时器间隔时间 */
    private var fault:TimeInterval?/**< 卡顿的阙值 */
    
    
    //单例模式
    static let sharedInstance = DLFluencyMonitor()
    private override init() {
        
    }
    
    @objc func monitorThreadEntryPoint() {
        autoreleasepool { () -> () in
            Thread.current.name = "FluencyMonitor";
            let runLoop:RunLoop = RunLoop.current;
            runLoop.add(NSMachPort(), forMode: .defaultRunLoopMode)
            runLoop.run()
        }
    }
    
    func startWithInterval(interval:TimeInterval,fault:TimeInterval) {
        self.interval = interval
        self.fault = fault
        
        guard self.observer == nil else{
            return
        }
        
        //1.创建observer
        var _self = self
        withUnsafeMutablePointer(to: &_self) { (pSelf) -> Void in
            var observerContext = CFRunLoopObserverContext(version: 0, info: pSelf, retain: nil, release: nil, copyDescription: nil)
            
            withUnsafeMutablePointer(to: &observerContext, { (pObserverContext) -> Void in
                
                self.observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, DLFluencyMonitor.runLoopObserverCallBack as! CFRunLoopObserverCallBack, pObserverContext)
                
                //2.将observer添加到主线程的RunLoop中
                CFRunLoopAddObserver(CFRunLoopGetMain(), self.observer, CFRunLoopMode.commonModes)
                
                //3.创建一个timer，并添加到子线程的RunLoop中
                self.perform(#selector(addTimerToMonitorThread), on: self.monitorThread!, with: nil, waitUntilDone: false, modes: [RunLoopMode.commonModes.rawValue])

                
            })
        }
        
//        //1.创建observer
//        let context = CFRunLoopObserverContext(version: 0, info: (), retain: CFNull, release: CFNull, copyDescription: CFNull)
//
//        self.observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, &runLoopObserverCallBack, &context)
    }
    
    @objc func addTimerToMonitorThread() {
        guard self.timer == nil else{
            return
        }
        //创建一个Timer
        let currentRunLoop = CFRunLoopGetCurrent()
        var _self = self
        withUnsafeMutablePointer(to: &_self) { (pSelf) -> Void in
            var context = CFRunLoopTimerContext(version: 0, info: pSelf, retain: nil, release: nil, copyDescription: nil)
            withUnsafeMutablePointer(to: &context, { (pContext) -> Void in
                self.timer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0.1, self.interval!, 0, 0, DLFluencyMonitor.runLoopTimerCallBack as! CFRunLoopTimerCallBack, pContext)
                //添加到子线程的RunLoop中
                CFRunLoopAddTimer(currentRunLoop, self.timer, CFRunLoopMode.commonModes)
            })
        }
        
    }
    
    @objc func removeTimer() {
        if let _ = self.timer {
            let currentRunLoop = CFRunLoopGetCurrent()
            CFRunLoopRemoveTimer(currentRunLoop, self.timer, CFRunLoopMode.commonModes)
            self.timer = nil
        }
    }
    
    func stop() {
        if let _ = self.observer {
            CFRunLoopRemoveObserver(CFRunLoopGetMain(), self.observer, CFRunLoopMode.commonModes)
            self.observer = nil
        }
        self.perform(#selector(removeTimer), on: self.monitorThread!, with: nil, waitUntilDone: false, modes: [RunLoopMode.commonModes.rawValue])
    }
    
    func handleStackInfo() {
        /*
         NSData *lagData = [[[PLCrashReporter alloc]
         initWithConfiguration:[[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll]] generateLiveReport];
         PLCrashReport *lagReport = [[PLCrashReport alloc] initWithData:lagData error:NULL];
         NSString *lagReportString = [PLCrashReportTextFormatter stringValueForCrashReport:lagReport withTextFormat:PLCrashReportTextFormatiOS];
         //将字符串上传服务器
         NSLog(@"lag happen, detail below: \n %@",lagReportString);
         */
    }
    
    static func runLoopObserverCallBack(observer:CFRunLoopObserver,activity:CFRunLoopActivity,info:UnsafeMutableRawPointer) {
//        let monitor = UnsafeMutablePointer<DLFluencyMonitor>(info)
//        print(monitor)
        //http://blog.csdn.net/zenny_chen/article/details/53455940
        let monitor = info.assumingMemoryBound(to: type(of: DLFluencyMonitor.self));
        
        switch activity {
        case CFRunLoopActivity.entry:
            print("CFRunLoopActivity.entry")
        case CFRunLoopActivity.beforeTimers:
            print("CFRunLoopActivity.beforeTimers")
        case CFRunLoopActivity.beforeSources:
            print("CFRunLoopActivity.beforeSources")
        case CFRunLoopActivity.beforeWaiting:
            print("CFRunLoopActivity.beforeWaiting")
        case CFRunLoopActivity.afterWaiting:
            print("CFRunLoopActivity.afterWaiting")
        case CFRunLoopActivity.exit:
            print("CFRunLoopActivity.exit")
        default:
            print("else case")
        }
    }
    
    static func runLoopTimerCallBack(timer:CFRunLoopTimer,info:UnsafeMutableRawPointer) {
        /*
         FluencyMonitor *monitor = (__bridge FluencyMonitor*)info;
         if (!monitor.excuting) {
         return;
         }
         
         // 如果主线程正在执行任务，并且这一次loop 执行到 现在还没执行完，那就需要计算时间差
         NSTimeInterval excuteTime = [[NSDate date] timeIntervalSinceDate:monitor.startDate];
         NSLog(@"定时器---%@",[NSThread currentThread]);
         NSLog(@"主线程执行了---%f秒",excuteTime);
         
         if (excuteTime >= monitor.fault) {
         NSLog(@"线程卡顿了%f秒",excuteTime);
         [monitor handleStackInfo];
         }
         */
    }
    
    

    
    
}
