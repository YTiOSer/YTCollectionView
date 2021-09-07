//
//  ViewController.m
//  OcAndSwiftMixCodeTest
//
//  Created by 杨涛 on 2021/2/1.
//  Copyright © 2021 杨涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//@property(nonatomic, strong) CarStruct car;
@property(nonatomic, strong) CarClass* car;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self textHighFunction];
}

- (NSString *)getCarName {
    return [self.car getCarName];
}

// 测试swift闭包
- (void)textSwiftClosures {
    
    self.swiftVc = [[SwiftTest alloc] init];
    self.swiftVc.textClosures = ^{
        printf("aaaaa");
    };
}

/// 测试swift高阶函数
- (void)textHighFunction {
    
    TextHighFunction *highDunction = [[TextHighFunction alloc] init];
    [highDunction functionHandle];
}

@end
