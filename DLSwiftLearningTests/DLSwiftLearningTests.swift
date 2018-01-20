//
//  DLSwiftLearningTests.swift
//  DLSwiftLearningTests
//
//  Created by denglong on 2017/10/26.
//  Copyright © 2017年 ubtrobot. All rights reserved.
//  Quick的概念解释：每个it代表一小段测试，describe和context则是it示例的逻辑群集（logical groupings），用来描述你要测试的是什么
//  http://www.cocoachina.com/ios/20171114/21160.html

//import XCTest
import Nimble
import Quick

@testable import DLSwiftLearning  //这一行基本上就是标示出我们正在测试的项目目标

class DLSwiftLearningTests: QuickSpec {
    
    
    //完全走不通啊，妈了个蛋蛋，妈蛋：走的通了，不能用真机跑！！！
    override func spec() {
        
        var subject: DLMoviesTableViewController!
        //第一个测试案例
        describe("DLMoviesTableViewController") {
            beforeEach {//表明它将在每个范例开始之前运行，所以你可以把它看作为在MoviesTableViewController内的每一个测试被执行前，会先运行这段代码
                subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DLMoviesTableViewController") as! DLMoviesTableViewController
                _ = subject.view  //将视图控制器放入内存中，它就像是调用viewDidLoad
            }
            
            context("when view is loaded") {
                it("Should have 8 movies loaded") {
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(8))
//                    fail()
                }
            }
            
            context("Table View", {
                var cell: UITableViewCell!
                beforeEach {
                    cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                }
                it("should show movie title and genre", closure: {
                    expect(cell.textLabel?.text).to(equal("The Emoji Movie"))
                    expect(cell.detailTextLabel?.text).to(equal("Animation"))
                })
            })
        }
    }
    
}
