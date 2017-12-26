//
//  DLCrashHandler.swift
//  DLSwiftLearning
//
//  Created by denglong on 26/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  swift版本参考：https://www.cnblogs.com/Code-life/p/7103697.html
//  原理解释：http://blog.csdn.net/zzzzzdddddxxxxx/article/details/53695599



import UIKit

public typealias Competion = ()->Void
public typealias CrashCallback = (String,Competion)->Void;

public var crashCallBack:CrashCallback?
public var ignore:Bool = false

func signalHandler(signal:Int32) -> Void {
    var stackTrace = String()
    for symbol in Thread.callStackSymbols {
        stackTrace = stackTrace.appendingFormat("%@\r\n", symbol)
    }
    if crashCallBack != nil {
        crashCallBack!(stackTrace,{
            unregisterSignalHandler()
            arouseApp()
            exit(signal)
        })
    }
}

//唤醒app
func arouseApp(){
    let runLoop = CFRunLoopGetCurrent()
    let allModes = CFRunLoopCopyAllModes(runLoop)
    
    while (!ignore) {
        for mode in allModes!{
            //原理：将当前runloop的所有mode再重新运行一遍
            CFRunLoopRunInMode(mode as! CFRunLoopMode, 0.001, false)
        }
    }
}

func registerSignalHanlder()
{
    signal(SIGINT, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGTRAP, signalHandler);
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
}

func unregisterSignalHandler()
{
    signal(SIGINT, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGTRAP, SIG_DFL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
}




class DLCrashHandler: NSObject {
    static func setup(callBack:@escaping CrashCallback) -> Void {
        registerSignalHanlder()
    }
}


//https://gist.github.com/alexaubry/f1f725ecce79756c2991b47b8cdaef0a
extension CFArray: Sequence {
    
    public func makeIterator() -> Iterator {
        return Iterator(self)
    }
    
    public struct Iterator: IteratorProtocol {
        
        var array: NSArray
        var idx = 0
        
        init(_ array: CFArray){
            self.array = array as NSArray
        }
        
        public mutating func next() -> Any? {
            guard idx < array.count else { return nil }
            let value = array[idx]
            idx += 1
            return value
        }
        
    }
    
}






