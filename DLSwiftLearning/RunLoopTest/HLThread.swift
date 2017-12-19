//
//  HLThread.swift
//  DLRunLoopTestProject
//
//  Created by denglong on 19/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

//封装的日志输出功能（T表示不指定日志信息参数类型）
func HGLog<T>(_ message:T, file:String = #file, function:String = #function,
              line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}

class HLThread: Thread {
    deinit {
        HGLog("进程销毁！")
    }
}
