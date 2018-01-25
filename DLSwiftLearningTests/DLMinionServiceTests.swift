//
//  DLMinionServiceTests.swift
//  DLSwiftLearningTests
//
//  Created by denglong on 25/01/2018.
//  Copyright © 2018 ubtrobot. All rights reserved.
//

import UIKit
import Nimble
import Quick
@testable import DLSwiftLearning
class DLMinionServiceTests: QuickSpec {
    class Fake_MinioeService: MinionService {//虚拟数据服务  提供虚拟数据
        var getTheMinionsWasCalled = false
        var fakeResult: MinionService.MinionDataResult?
        
        override func getTheMinions(completionHandler: (MinionService.MinionDataResult) -> Void) {
            getTheMinionsWasCalled = true
            completionHandler(fakeResult!)
        }
    }
    
    override func spec() {
        var viewController: DLUnitiTestSampleTable!
        
        beforeEach {//每一次测试前都要预先运行的代码块
            //获取storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            //获取导航控制器
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            viewController = navigationController.topViewController as! DLUnitiTestSampleTable
            
            //设置循环
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            RunLoop.main.run(until: Date())
            
        }
        
        //测试集
        describe(".fetchMinions") {
            context("Minions are fetched successfully", closure: {
                it("sets the minions as the data source", closure: {
                    let fakeMiniosService = Fake_MinioeService()
                    let minions = [Minion(name: "Bob"),Minion(name: "Dave")]
                    fakeMiniosService.fakeResult = MinionService.MinionDataResult.Success(minions)
                    viewController.fetchMinions(minionService: fakeMiniosService)//传递虚拟数据
                    
                    expect(fakeMiniosService.getTheMinionsWasCalled).to(beTrue())//期望应该为true
                    expect(minions).to(equal(viewController.dataSource))//预期DataSource应该能完全传递过去
                })
            })
            
            //会导致失败的单元测试
            context("There is an error fatching minions", closure: {
                it("shows an alert with error", closure: {
                    let fakeMinionService = Fake_MinioeService()
                    //构造错误
                    let error = NSError(domain: "Error", code: 400, userInfo: [NSLocalizedDescriptionKey : "Oops! The Minions are missing on a new fun adventure!"])
                    fakeMinionService.fakeResult = MinionService.MinionDataResult.Failure(error)
                    viewController.fetchMinions(minionService: fakeMinionService)
                    
                    expect(fakeMinionService.getTheMinionsWasCalled).to(beTrue())//期望是能够调用到此方法的
                })
            })
        }
        
        
        
    }
}
