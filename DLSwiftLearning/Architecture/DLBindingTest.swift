//
//  DLBindingTest.swift
//  DLSwiftLearning
//
//  Created by denglong on 09/01/2018.
//  Copyright © 2018 ubtrobot. All rights reserved.
//  https://www.jianshu.com/p/072552705610
//  Bindings

//Mac OS直接就支持Binding，但是iOS并不支持。当然iOS支持KVO和notification，但是没有binding方便。


//MVVM模式简单尝试  如果使用Binding技术可以大大的减少代码量  Functional Reactive Programming框架，例如ReactiveCocoa，RxSwift。

import UIKit

class DLBindingTest: NSObject {
    func test() {
        //Assembling of MVVM
        let model = BTPerson(firstName: "John", lastName: "Smith")
        let viewModel = GreetingViewModel(person: model)
        let view = GreetingViewController()
        view.viewModel = viewModel
    }
}

struct BTPerson {
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol: class {
    var greeting: String? {get}
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? {get set} //闭包
    init(person: BTPerson)
    func showGreeting()
}

class GreetingViewModel: GreetingViewModelProtocol {
    let person: BTPerson
    var greeting: String? {
        didSet{
            self.greetingDidChange!(self)//逻辑通过闭包呈现给controller改变界面
        }
    }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?
    required init(person: BTPerson) {
        self.person = person
    }
    
    func showGreeting() {
        self.greeting = "Hello \(self.person.firstName) \(self.person.lastName)"
        //属性的变更，调用闭包，通知外部的viewcontroller来更新界面
    }
}

class GreetingViewController: UIViewController {
    var viewModel: GreetingViewModelProtocol! {
        didSet{
            self.viewModel.greetingDidChange = {[unowned self] viewModel in
                self.greetingLabel.text = viewModel.greeting
            }
        }
    }
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self.viewModel, action: Selector(("showGreeting")), for: .touchUpInside)
        //逻辑放在viewmodel中
    }
    
}
