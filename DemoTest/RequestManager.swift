//
//  RequestManager.swift
//  DemoTest
//
//  Created by 杨涛 on 2020/4/29.
//  Copyright © 2020 杨涛. All rights reserved.
//

import UIKit

class SMSCodeModel: NSObject {
    required override init() {
        super.init()
    }
    @objc var code: String = ""
}

class RequestManager: NSObject {

    class func getSMSCode(phone: String, result: ((SMSCodeModel?) -> Void)?) {
        let params = ["phone": phone]
        
    }
    
    class func login(with phone: String, smsCode: String, result: ((LoginModel?) -> Void)?) {
        let params = ["phone": phone, "smsCode": smsCode]
        
    }
}
