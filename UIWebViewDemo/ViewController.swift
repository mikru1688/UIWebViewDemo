//
//  ViewController.swift
//  UIWebViewDemo
//
//  Created by Frank.Chen on 2017/3/28.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol JavaScriptFuncProtocol: JSExport {
    func test(_ value: String)
    func test2(_ value: String, _ num: Int)
}

class JavaScriptFunc : NSObject, JavaScriptFuncProtocol {
    func test(_ value: String) {
        print("value: \(value)")
    }
    
    func test2(_ value: String, _ num: Int) {
        print("value: \(value), num: \(num)")
    }
}

class ViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (一)取得bundle下的.html並顯示在WebView內
//        let path = Bundle.main.path(forResource: "SwiftUseJavaScriptDemo_1", ofType: "html")
//        let htmlStr: String = try! String(contentsOfFile: path!)
//        
//        self.webView = UIWebView()
//        self.webView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        self.webView.loadHTMLString(htmlStr, baseURL: nil)
//        self.view.addSubview(self.webView)
        
        
        // (二)使用JSContext來執行JavaScript
//        let context: JSContext = JSContext()
//        
//        // 定義js變數和函數
//        context.evaluateScript("var num1 = 10; var num2 = 20;")
//        context.evaluateScript("function add(par1, par2) { return par1 + par2; }")
//        
//        // 方式1. 直接呼叫js函數
//        let result: JSValue = context.evaluateScript("add(num1, num2)")
//        print("result: \(result)") // 30
//        
//        // 方式2. 利用下標來獲取js函數並呼叫之
//        let result2 = context.objectForKeyedSubscript("add").call(withArguments: [10, 20]).toString()
//        print("result2: \(result2!)") // 30
        
        
        // (三)JavaScript call Swfit func
        // 取得bundle的SwiftUseJavaScriptDemo_2.html的內容並顯示在WebView內
//        let path = Bundle.main.path(forResource: "SwiftUseJavaScriptDemo_2", ofType: "html")
//        let htmlStr: String = try! String(contentsOfFile: path!)
//
//        self.webView = UIWebView()
//        self.webView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        self.webView.loadHTMLString(htmlStr, baseURL: nil)
//        self.view.addSubview(self.webView)
//        
//        let jsContext = self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
//        jsContext?.setObject(JavaScriptFunc(), forKeyedSubscript: "javaScriptCallToSwift" as (NSCopying & NSObjectProtocol)!)
        
        
        // (四)Swfit call JavaScript func
        let path = Bundle.main.path(forResource: "SwiftUseJavaScriptDemo_3", ofType: "html")
        let htmlStr: String = try! String(contentsOfFile: path!)
        
        self.webView = UIWebView()
        self.webView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.webView.loadHTMLString(htmlStr, baseURL: nil)
        self.view.addSubview(self.webView)
        
        // 生成Call JS Button
        let callJSBtn: UIButton = UIButton()
        callJSBtn.frame = CGRect(x: 0, y: 100, width: 200, height: 50)
        callJSBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        callJSBtn.setTitle("calJS", for: .normal)
        callJSBtn.layer.cornerRadius = 10
        callJSBtn.layer.masksToBounds = true
        callJSBtn.backgroundColor = UIColor.darkGray
        callJSBtn.addTarget(self, action: #selector(ViewController.calJS(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(callJSBtn)
    }
    
    // Call JS Event
    func calJS(_ sender: UIButton) {
        // 獲得當前頁面中的上下文
        let jsContext = self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        jsContext?.objectForKeyedSubscript("fromNative")!.call(withArguments: ["Random: \(Int(arc4random_uniform(10) + 1))"])
    }
}

