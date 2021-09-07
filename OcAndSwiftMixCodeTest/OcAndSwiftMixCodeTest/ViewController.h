//
//  ViewController.h
//  OcAndSwiftMixCodeTest
//
//  Created by 杨涛 on 2021/2/1.
//  Copyright © 2021 杨涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OcAndSwiftMixCodeTest-Swift.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) void (^myblock) (NSString *name);

@property(nonatomic, strong) SwiftTest *swiftVc;

@end

